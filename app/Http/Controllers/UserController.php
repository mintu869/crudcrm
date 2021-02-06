<?php


namespace App\Http\Controllers;


use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\User;
use Spatie\Permission\Models\Role;
use Spatie\Permission\Models\Permission;
use Illuminate\Support\Facades\Auth;
use DB;
use Hash;


class UserController extends Controller
{
	function __construct()
    {
         $this->middleware('permission:user-list|user-create|user-edit|user-delete', ['only' => ['index','show']]);
         $this->middleware('permission:user-create', ['only' => ['create','store']]);
         $this->middleware('permission:user-edit', ['only' => ['edit','update']]);
         $this->middleware('permission:user-delete', ['only' => ['destroy']]);
    }
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request, $type)
    {	
        $data = User::orderBy('id','DESC')->where('type',ucfirst($type))->paginate(5);
        return view('users.index',compact('data','type'))
            ->with('i', ($request->input('page', 1) - 1) * 5);
    }


    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create($type="")
    {
		$roles = $this->getRoles();
		$types = $this->getTypes();
        return view('users.create',compact('roles','types','type'));
    }
	
	public function getRoles() {
		$roles = [];
		$currentUserRole = Auth::user()->getRoleNames();
		$currentUserRole = $currentUserRole[0];
		
		switch($currentUserRole){
			case 'Admin':
				$roles = Role::pluck('name','name')->all();
			break;
			case 'Sales Representative':
				$roles = Role::whereNotIn('id',[1,2])->pluck('name','name')->all();
			break;
		}
		return $roles;
	}
	
	public function getTypes () {
		$types = config('app.user_types');
		$currentUserRole = Auth::user()->getRoleNames();
		$currentUserRole = $currentUserRole[0];
		
		switch($currentUserRole){
			case 'Admin':
				$types = config('app.user_types');
			break;
			case 'Sales Representative':
				$types = config('app.user_types');
				unset($types['SalesRep']);
			break;
		}
		return $types;
	}


    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $this->validate($request, [
            'name' => 'required',
            'email' => 'required|email|unique:users,email',
            'password' => 'required|same:confirm-password',
            'roles.*' => 'required',
            'type.*' => 'required'
        ]);


        $input = $request->all();
        $input['password'] = Hash::make($input['password']);
		$type = (@$input['type'][0]!="")?$input['type'][0]:"Customer";
		$input['type'] = $type;
        $user = User::create($input);
        $user->assignRole($request->input('roles'));
        return redirect(url('users/'.$type))
                        ->with('success',ucfirst($type).'  created successfully');
    }


    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $user = User::find($id);
        return view('users.show',compact('user'));
    }


    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        $user = User::find($id);
        $roles = $this->getRoles();
		$types = $this->getTypes();
        $userRole = $user->roles->pluck('name','name')->all();
		return view('users.edit',compact('user','roles','userRole','types'));
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
        $this->validate($request, [
            'name' => 'required',
            'email' => 'required|email|unique:users,email,'.$id,
            'password' => 'same:confirm-password',
            'roles.*' => 'required',
			'type.*' => 'required',
        ]);


        $input = $request->all();
		$input['type'] = $type = (@$input['type'][0]!="")?@$input['type'][0]:"Customer";
        if(!empty($input['password'])){ 
            $input['password'] = Hash::make($input['password']);
        }else{
            $input = array_except($input,array('password'));    
        }
        $user = User::find($id);
        $user->update($input);
        DB::table('model_has_roles')->where('model_id',$id)->delete();
        $user->assignRole($request->input('roles'));
        return redirect(url('users/'.$user->type))
                        ->with('success',ucfirst($type).'  updated successfully');
    }


    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $user = User::find($id);
		$type = $user->type;
		$user->delete();
        return redirect(url('users/'.$type))
                        ->with('success',ucfirst($type).' deleted successfully');
    }
}