<?php

namespace App\Http\Controllers\Api;

use App\Models\Product;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Storage;

class ProductController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $products = Product::latest()->get();

        return response()->json([
            'success' => true,
            'message' => 'List products',
            'data' => $products
        ], 200);
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
            'nama_produk' => 'required|string|max:255',
            'ketersediaan_stok' => 'required|integer|min:0',
            'harga' => 'required|numeric|min:0',
            'description' => 'nullable|string',

            'foto' => 'nullable|image|mimes:jpg,jpeg,png|max:2048',
        ]);

        $fotoPath = null;

        if ($request->hasFile('foto')) {
            $fotoPath = $request->file('foto')
                ->store('products', 'public');
        }

        $product = Product::create([
            'nama_produk' => $request->nama_produk,
            'ketersediaan_stok' => $request->ketersediaan_stok,
            'description' => $request->description,
            'harga' => $request->harga,
            'foto' => $fotoPath,
        ]);

        return response()->json([
            'success' => true,
            'message' => 'Product berhasil dibuat',
            'data' => $product
        ], 201);
    }


    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show(Product $product)
    {
        return response()->json([
            'success' => true,
            'message' => 'Product detail',
            'data' => $product
        ], 200);
    }


    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Product $product)
    {
        $request->validate([
            'nama_produk' => 'required|string|max:255',
            'ketersediaan_stok' => 'required|integer|min:0',
            'harga' => 'required|numeric|min:0',
            'description' => 'nullable|string',
            'foto' => 'nullable|image|max:2048',
        ]);

        if ($request->hasFile('foto')) {
            if ($product->foto && Storage::disk('public')->exists($product->foto)) {
                Storage::disk('public')->delete($product->foto);
            }

            $product->foto = $request->file('foto')
                ->store('products', 'public');
        }

        $product->update([
            'nama_produk' => $request->nama_produk,
            'ketersediaan_stok' => $request->ketersediaan_stok,
            'description' => $request->description,
            'harga' => $request->harga,
        ]);

        return response()->json([
            'success' => true,
            'message' => 'Product berhasil diupdate',
            'data' => $product->fresh()
        ]);
    }



    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy(Product $product)
    {
        // HAPUS FILE FOTO JIKA ADA
        if ($product->foto && Storage::disk('public')->exists($product->foto)) {
            Storage::disk('public')->delete($product->foto);
        }
        
        $product->delete();

        return response()->json([
            'success' => true,
            'message' => 'Product deleted'
        ], 200);
    }
}
