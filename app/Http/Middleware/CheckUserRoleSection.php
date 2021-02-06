<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Support\Facades\Auth;

class CheckUserRoleSection
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @return mixed
     */
    public function handle($request, Closure $next)
    {
		$segs = $request->segments();
		if(count($segs) == 1 && in_array('users',$segs)){
			 return redirect('/home');
		}
		else {
           if(Auth::user()->hasRole('Sales Representative') && in_array('salesrep',$segs)){
				return redirect('/home');
			}
			if(Auth::user()->hasRole('Contributor') && (in_array('salesrep',$segs) || in_array('contributor',$segs))){
				return redirect('/home');
			}
        }
		 return $next($request);
    }
}
