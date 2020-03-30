entity cloth;
void (vector) Make_Cloth;
void () ArraySet*cloth;
void () ArrayGet*cloth;
void(vector topleft_org) Make_Cloth = asm
{
local float locked_823;
local vector point_org;
local entity joint;
local entity flag_sphere;
local float jointpos;
local float y_pos;
local float x_pos;
local float i;
local float y_width;
local float x_width;
local float y;
local float x;
local vector temp_1;
local float temp_3;
	STORE_F	9.000000,	x; /*328*/
	STORE_F	9.000000,	y; /*329*/
	STORE_F	10.000000,	x_width; /*331*/
	STORE_F	10.000000,	y_width; /*332*/
	STORE_F	1.000000,	i; /*334*/
	LT		i,	89.000000,	locked_823; /*335*/
	IFNOT		locked_823,	7; /*335*/
	STORE_F	i,	parm0_x; /*336*/
	STORE_F	world,	parm1_x; /*336*/
	CALL2		ArraySet*cloth; /*336*/
	STORE_F	i,	locked_823; /*337*/
	ADD_F		i,	1.000000,	i; /*337*/
	GOTO		-7; /*341*/
	STORE_F	0.000000,	i; /*341*/
	MUL_F		x,	y,	locked_823; /*342*/
	LT		i,	locked_823,	locked_823; /*342*/
	IFNOT		locked_823,	34; /*342*/
	STORE_V	topleft_org,	point_org; /*343*/
	MUL_F		y_width,	y_pos,	locked_823; /*344*/
	SUB_F		point_org_z,	locked_823,	point_org_z; /*344*/
	MUL_F		x_width,	x_pos,	locked_823; /*345*/
	ADD_F		point_org_x,	locked_823,	point_org_x; /*345*/
	STORE_V	point_org,	parm0; /*346*/
	STORE_F	"progs/phys/phys_sphere.mdl",	parm1_x; /*346*/
	STORE_F	0.000000,	parm2_x; /*346*/
	STORE_F	0.300000,	parm3_x; /*346*/
	CALL4		Bone_MakeBone; /*346*/
	STORE_F	i,	parm0_x; /*346*/
	STORE_F	return_x,	parm1_x; /*346*/
	CALL2		ArraySet*cloth; /*346*/
	STORE_F	i,	parm0_x; /*347*/
	CALL1		ftos; /*347*/
	STORE_F	return_x,	parm0_x; /*347*/
	STORE_F	" aye
",	parm1_x; /*347*/
	CALL2		print; /*347*/
	STORE_F	x_pos,	locked_823; /*349*/
	ADD_F		x_pos,	1.000000,	x_pos; /*349*/
	GE		x_pos,	x,	locked_823; /*350*/
	IFNOT		locked_823,	4; /*350*/
	STORE_F	0.000000,	x_pos; /*351*/
	STORE_F	y_pos,	locked_823; /*352*/
	ADD_F		y_pos,	1.000000,	y_pos; /*352*/
	GT		x_pos,	x,	locked_823; /*355*/
	GT		y_pos,	y,	temp_383; /*355*/
	OR		locked_823,	temp_383,	locked_823; /*355*/
	IFNOT		locked_823,	2; /*355*/
	GOTO		4; /*356*/
	STORE_F	i,	locked_823; /*358*/
	ADD_F		i,	1.000000,	i; /*358*/
	GOTO		-35; /*361*/
	STORE_F	0.000000,	x_pos; /*361*/
	STORE_F	0.000000,	y_pos; /*362*/
	STORE_F	0.000000,	x_width; /*363*/
	STORE_F	0.000000,	y_width; /*364*/
	MUL_F		y_pos,	x,	locked_823; /*367*/
	ADD_F		x_pos,	locked_823,	jointpos; /*367*/
	STORE_ENT	cloth,	cloth[1]; /*368*/
	STORE_F	jointpos,	parm0_x; /*369*/
	CALL1		ArrayGet*cloth; /*369*/
	ADD_F		jointpos,	1.000000,	parm0_x; /*369*/
	STORE_F	return_x,	locked_823; /*369*/
	CALL1		ArrayGet*cloth; /*369*/
	STORE_F	return_x,	temp_383; /*369*/
	STORE_F	locked_823,	return_x; /*369*/
	EQ_E		return_x,	temp_383,	locked_823; /*369*/
	IFNOT		locked_823,	13; /*369*/
	STORE_F	jointpos,	parm0_x; /*370*/
	CALL1		ArrayGet*cloth; /*370*/
	INDIRECT_V	return_x,	origin_x,	parm0; /*370*/
	CALL1		vtos; /*370*/
	STORE_F	return_x,	parm0_x; /*370*/
	STORE_F	" origin 1
",	parm1_x; /*370*/
	CALL2		print; /*370*/
	INDIRECT_V	cloth[1],	origin_x,	parm0; /*371*/
	CALL1		vtos; /*371*/
	STORE_F	return_x,	parm0_x; /*371*/
	STORE_F	" origin 11
",	parm1_x; /*371*/
	CALL2		print; /*371*/
	DONE; /*401*/
}

