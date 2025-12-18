<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     *
     * @return void
     */
    public function run()
    {
        User::updateOrCreate(
            ['email' => 'admin@test.com'], 
            [
                'name' => 'Admin Gulung',
                'password' => Hash::make('password'), 
                'role' => 'admin',       
                'status' => 'approved',  
            ]
        );

        // 2. (Opsional) Buat 1 User Biasa buat tes
        User::updateOrCreate(
            ['email' => 'user@test.com'],
            [
                'name' => 'User Testing',
                'password' => Hash::make('password'),
                'role' => 'user',
                'status' => 'approved',
            ]
        );
    }
}
