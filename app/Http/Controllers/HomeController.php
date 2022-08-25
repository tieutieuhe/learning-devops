<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\User;

class HomeController extends Controller
{
    public function __invoke()
    {
        $users = User::all();

        return view('app',compact('users'));
    }
}
