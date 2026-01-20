<?php

namespace Database\Seeders;

use App\Models\Agenda;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class AgendaSeeder extends Seeder
{
    use WithoutModelEvents;

    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $agendas = [
            [
                'judul' => 'Rapat Koordinasi Project 5G',
                'keterangan' => 'Membahas progress pengembangan sistem Juliandra 5G dengan tim developer',
                'is_done' => false,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'judul' => 'Meeting dengan Client',
                'keterangan' => 'Presentasi prototype sistem kepada stakeholder',
                'is_done' => true,
                'created_at' => now()->subDays(2),
                'updated_at' => now()->subDay(),
            ],
            [
                'judul' => 'Pengujian Sistem',
                'keterangan' => 'Unit testing dan integration testing untuk modul agenda',
                'is_done' => false,
                'created_at' => now()->subDays(1),
                'updated_at' => now()->subHours(5),
            ],
            [
                'judul' => 'Update Dokumentasi API',
                'keterangan' => 'Menyempurnakan API documentation untuk endpoint agenda',
                'is_done' => false,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'judul' => 'Deployment ke Server',
                'keterangan' => 'Deploy aplikasi ke server production',
                'is_done' => false,
                'created_at' => now()->addDays(3),
                'updated_at' => now()->addDays(3),
            ],
            [
                'judul' => 'Review Kode',
                'keterangan' => 'Code review untuk pull request dari tim developer',
                'is_done' => false,
                'created_at' => now()->subHours(3),
                'updated_at' => now()->subHours(2),
            ],
            [
                'judul' => 'Maintenance Database',
                'keterangan' => 'Optimasi performa database dan backup data',
                'is_done' => true,
                'created_at' => now()->subDays(5),
                'updated_at' => now()->subDays(4),
            ],
            [
                'judul' => 'Pelatihan User',
                'keterangan' => 'Membimbing user dalam penggunaan sistem Juliandra 5G',
                'is_done' => false,
                'created_at' => now()->addDays(7),
                'updated_at' => now()->addDays(7),
            ],
        ];

        foreach ($agendas as $agenda) {
            Agenda::create($agenda);
        }
    }
}

