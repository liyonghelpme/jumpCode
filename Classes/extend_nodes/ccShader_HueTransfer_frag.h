"                                            \n\
#ifdef GL_ES                                \n\
precision mediump float;                      \n\
#endif                                        \n\
                                            \n\
varying vec4 v_fragmentColor;                \n\
varying vec2 v_texCoord;                    \n\
uniform sampler2D u_texture;                \n\
uniform float u_hueOffset;                    \n\
void main()                              \n\
{                                            \n\
	vec3 rgb = texture2D(u_texture, v_texCoord).rgb;  \n\
	float h=0.0;\n\
	float min = rgb.r;\n\
	if(min>rgb.g)\n\
		min=rgb.g;\n\
	if(min>rgb.b)\n\
		min=rgb.b;\n\
	float max = rgb.r;\n\
	if(max<rgb.g)\n\
		max=rgb.g;\n\
	if(max<rgb.b)\n\
		max=rgb.b;\n\
	float v=max;\n\
	float s=0.0;\n\
	if(v>0.0)\n\
		s=(max-min)/max;\n\
	if(max>min){\n\
		if(max==rgb.r){\n\
			if(rgb.g>rgb.b)\n\
				h=(rgb.g-rgb.b)/(max-min);\n\
			else\n\
				h=(rgb.g-rgb.b)/(max-min) + 6.0;\n\
		}\n\
		else if(max==rgb.g)\n\
			h=(rgb.b-rgb.r)/(max-min) + 2.0;\n\
		else\n\
			h=(rgb.r-rgb.g)/(max-min) + 4.0;\n\
	}\n\
	h=h+u_hueOffset;\n\
	if(h>=6.0)\n\
		h=h-6.0;\n\
	float p=v*(1.0-s);\n\
	if(h<1.0)\n\
		rgb=vec3(v, v*(1.0-(1.0-h)*s), p);\n\
	else if(h<2.0)\n\
		rgb=vec3(v * (1.0-(h-1.0)*s), v, p);\n\
	else if(h<3.0)\n\
		rgb=vec3(p, v, v*(1.0-(3.0-h)*s));\n\
	else if(h<4.0)\n\
		rgb=vec3(p, v * (1.0-(h-3.0)*s), v);\n\
	else if(h<5.0)\n\
		rgb=vec3(v*(1.0-(5.0-h)*s), p, v);\n\
	else\n\
		rgb=vec3(v, p, v * (1.0-(h-5.0)*s));\n\
	gl_FragColor = vec4(rgb, texture2D(u_texture, v_texCoord).a);            \n\
}";