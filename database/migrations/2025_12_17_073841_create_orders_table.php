<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateOrdersTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up(): void
    {
        Schema::create('orders', function (Blueprint $table) {
            $table->id();

            $table->foreignId('user_id')
                ->constrained()
                ->cascadeOnDelete();

            $table->foreignId('product_id')
                ->constrained()
                ->cascadeOnDelete();

            $table->integer('total_barang');

            $table->boolean('balado')->default(false);
            $table->boolean('keju')->default(false);
            $table->boolean('pedas')->default(false);
            $table->boolean('asin')->default(false);
            $table->boolean('barbeque')->default(false);

            $table->decimal('total_harga', 12, 2);

            $table->string('status')->default('menunggu antrian');

            $table->timestamps();
        });
    }


    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('orders');
    }
}
