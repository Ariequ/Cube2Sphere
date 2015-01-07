Shader "Custom/Cube2Circle" {
	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_Radius ("Radius", Range(0,1)) = 2
		_Speed("Speed", Range(0.1, 80)) = 5
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		#pragma surface surf Lambert vertex:vert

		sampler2D _MainTex;
		float _Speed;
		float _Radius;

		struct Input {
			float2 uv_MainTex;
			float3 vertColor;
		};
		
		void vert(inout appdata_full v, out Input o)
		{		
			float len =  (_Radius - length(v.vertex.xyz))*((sin(_Time * _Speed) + 1) / 2);
			v.vertex.xyz = v.vertex.xyz + normalize(v.vertex.xyz) * len;
			v.normal = normalize(v.vertex.xyz);
		}

		void surf (Input IN, inout SurfaceOutput o) {
			half4 c = tex2D (_MainTex, IN.uv_MainTex);
			o.Albedo = c.rgb;
			o.Alpha = c.a;
		}
		ENDCG
	} 
	FallBack "Diffuse"
}
