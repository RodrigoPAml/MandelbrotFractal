#version 330 core

uniform vec2 resolution;
uniform vec2 center;
uniform float zoom;
uniform int max_iterations;

out vec4 fragColor;

void main()
{
    vec2 c = (gl_FragCoord.xy / resolution - 0.5) * zoom + center ;
    vec2 z = vec2(0.0, 0.0);
    long iterations = 0;

    for (int i = 0; i < max_iterations; i++) 
    {
        if (length(z) > 8.0) {
            break;
        }
        
        z = vec2(z.x * z.x - z.y * z.y, 2.0 * z.x * z.y) + c;
        
        iterations++;
    }

    if (iterations == max_iterations) 
    {
        fragColor = vec4(0, 0 , 0, 1.0); 
    }
    else
    {
        float colorValue = (float(iterations)/float(max_iterations))*(255);

        float r = 0.5 + 0.25 * cos(1/(zoom+0.01) * 1/colorValue + 0.0) + 0.25 * sin(1/(zoom+0.01) * 1/colorValue + 0.0);
        float g = 0.5 + 0.25 * cos(1/(zoom+0.01) * 1/colorValue + 2.0) + 0.25 * sin(1/(zoom+0.01) * 1/colorValue + 2.0);
        float b = 0.5 + 0.25 * cos(1/(zoom+0.01) * 1/colorValue + 4.0) + 0.25 * sin(1/(zoom+0.01) * 1/colorValue + 4.0);

        fragColor = vec4(r, g, b, 1);
    }
}