Shader "Custom/Cube2Circle" {
	Properties {
		_Radius ("Radius", Float) = 2
		_Speed("Speed", Float) = 5
        _Color ("Main Color", Color) = (1,1,1,1)
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		#pragma surface surf Lambert vertex:vert

		fixed4 _Color;
		float _Speed;
		float _Radius;

		struct Input {
			float2 uv_MainTex;
			float3 vertColor;
		};
		
		void vert(inout appdata_full v, out Input o)
		{		
			float len =  (_Radius - length(v.vertex.xyz))*((sin(_Time * _Speed) + 1)/2);
			v.vertex.xyz = v.vertex.xyz + normalize(v.vertex.xyz) * len;
			v.normal = normalize(v.vertex.xyz);
		}

		void surf (Input IN, inout SurfaceOutput o) {
			o.Albedo = _Color.rgb;
			o.Alpha = _Color.a;
		}
		ENDCG
	} 
	FallBack "Diffuse"
}
