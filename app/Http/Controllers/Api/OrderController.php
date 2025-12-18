<?php

namespace App\Http\Controllers\Api;

use App\Models\Order;
use App\Models\Product;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Http\Controllers\Controller;

class OrderController extends Controller
{
    // rumus harga total pada order
    // total_harga = harga_product × total_barang

    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {
        $user = auth()->user();

        $query = Order::with(['product', 'user'])
            ->latest();

        // FILTER STATUS (OPSIONAL)
        if ($request->filled('status')) {
            $query->where('status', $request->status);
        }

        // USER hanya lihat miliknya
        if ($user->role !== 'admin') {
            $query->where('user_id', $user->id);
        }

        return response()->json([
            'success' => true,
            'data' => $query->get()
        ]);
    }




    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $request->validate([
            'product_id' => 'required|exists:products,id',
            'total_barang' => 'required|integer|min:1',

            'balado' => 'boolean',
            'keju' => 'boolean',
            'pedas' => 'boolean',
            'asin' => 'boolean',
            'barbeque' => 'boolean',
        ]);

        return DB::transaction(function () use ($request) {

            // LOCK product row (anti double order)
            $product = Product::where('id', $request->product_id)
                ->lockForUpdate()
                ->first();

            // CEK STOK
            if ($product->ketersediaan_stok < $request->total_barang) {
                return response()->json([
                    'success' => false,
                    'message' => 'Stok produk tidak mencukupi'
                ], 422);
            }

            // HITUNG TOTAL HARGA
            $totalHarga = $product->harga * $request->total_barang;

            // SIMPAN ORDER
            $order = Order::create([
                'user_id' => auth()->id(),
                'product_id' => $product->id,
                'total_barang' => $request->total_barang,

                'balado' => $request->balado ?? false,
                'keju' => $request->keju ?? false,
                'pedas' => $request->pedas ?? false,
                'asin' => $request->asin ?? false,
                'barbeque' => $request->barbeque ?? false,

                'total_harga' => $totalHarga,
                'status' => 'menunggu antrian',
            ]);

            // KURANGI STOK
            $product->decrement('ketersediaan_stok', $request->total_barang);

            return response()->json([
                'success' => true,
                'message' => 'Order berhasil dibuat',
                'data' => $order
            ], 201);
        });
    }


    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show(Order $order)
    {
        $user = auth()->user();

        // ADMIN boleh lihat semua
        if ($user->role === 'admin') {
            $order->load(['user', 'product']);

            return response()->json([
                'success' => true,
                'data' => $order
            ]);
        }

        // USER hanya boleh lihat miliknya
        if ($order->user_id !== $user->id) {
            return response()->json([
                'message' => 'Forbidden'
            ], 403);
        }

        $order->load('product');

        return response()->json([
            'success' => true,
            'data' => $order
        ]);
    }


    // update status order untuk admin
    public function updateStatus(Request $request, Order $order)
    {
        $this->authorize('updateStatus', $order);

        $request->validate([
            'status' => 'required|in:menunggu_antrian,diproses,selesai,dibatalkan',
        ]);

        $order->update([
            'status' => $request->status,
        ]);

        return response()->json([
            'success' => true,
            'message' => 'Status order berhasil diperbarui',
            'data' => $order->fresh(),
        ]);
    }




    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        //
    }
}
