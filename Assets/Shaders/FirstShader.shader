Shader "Custom/FirstShader"
{
    Properties {
        _Tint ("Tint", Color) = (1,1,1,1)
        _MainTex ("Texture", 2D) = "white" {}
    }
    SubShader {
        Pass {
            CGPROGRAM
                #pragma target 3.0
                #pragma vertex MyVertexProgram
                #pragma fragment MyFragmentProgram

                #include "UnityCG.cginc"

                float4 _Tint;
                sampler2D _MainTex;
                float4 _MainTex_ST;

                // Use a unique structure name to avoid conflicts
                struct VertexInput {
                    float4 position : POSITION;
                    float2 uv : TEXCOORD0;
                };

                struct Interpolators {
                    float4 position : SV_POSITION;
                    float2 uv : TEXCOORD0;
                };

                // Vertex shader function
                Interpolators MyVertexProgram(VertexInput v) {
                    Interpolators i;
                    i.position = UnityObjectToClipPos(v.position);
                    i.uv = v.uv * _MainTex_ST.xy;
                    return i;
                }

                // Fragment shader function
                float4 MyFragmentProgram(Interpolators i) : SV_TARGET {
                    return tex2D(_MainTex, i.uv) * _Tint;
                }
            ENDCG
        }
    }
    Fallback "Diffuse"
}


