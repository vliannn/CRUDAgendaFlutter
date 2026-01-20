<?php

use App\Http\Controllers\AgendaController;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group.
|
*/

Route::prefix('agenda')->group(function () {
    Route::get('/', [AgendaController::class, 'index']);
    Route::post('/', [AgendaController::class, 'store']);
    Route::get('/{id}', [AgendaController::class, 'show']);
    Route::put('/{id}', [AgendaController::class, 'update']);
    Route::delete('/{id}', [AgendaController::class, 'destroy']);
});

