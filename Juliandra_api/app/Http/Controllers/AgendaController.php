<?php

namespace App\Http\Controllers;

use App\Models\Agenda;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class AgendaController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(): JsonResponse
    {
        $agenda = Agenda::all();
        return response()->json($agenda);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request): JsonResponse
    {
        $validated = $request->validate([
            'judul' => 'required|string|max:255',
            'keterangan' => 'nullable|string',
            'is_done' => 'nullable|boolean',
        ]);

        $agenda = Agenda::create($validated);

        return response()->json($agenda, 201);
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id): JsonResponse
    {
        $agenda = Agenda::find($id);

        if (!$agenda) {
            return response()->json([
                'message' => 'Agenda not found'
            ], 404);
        }

        return response()->json($agenda);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id): JsonResponse
    {
        $agenda = Agenda::find($id);

        if (!$agenda) {
            return response()->json([
                'message' => 'Agenda not found'
            ], 404);
        }

        $validated = $request->validate([
            'judul' => 'sometimes|required|string|max:255',
            'keterangan' => 'nullable|string',
            'is_done' => 'nullable|boolean',
        ]);

        $agenda->update($validated);

        return response()->json($agenda);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id): JsonResponse
    {
        $agenda = Agenda::find($id);

        if (!$agenda) {
            return response()->json([
                'message' => 'Agenda not found'
            ], 404);
        }

        $agenda->delete();

        return response()->json([
            'message' => 'Agenda deleted'
        ]);
    }
}

