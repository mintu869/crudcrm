<?php

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', function () {
    return view('welcome');
});

Auth::routes();

Route::get('/home', 'HomeController@index')->name('home');

Route::group(['middleware' => ['auth','userRoles']], function() {
    Route::resource('roles','RoleController');
	Route::get('users/{type?}', 'UserController@index');
	Route::get('create-user/{type?}', 'UserController@create');
    Route::post('save-user', 'UserController@store');
    Route::get('edit-user/{id}', 'UserController@edit');
    Route::get('show-user/{id}', 'UserController@show');
	Route::patch('update-user/{id}', 'UserController@update');
	Route::delete('delete-user/{id}', 'UserController@destroy');
});
