# Mandelbrot Fractal

Implementation of Mandelbrot Fractal using Box Engine with Lua and GLSL

Box engine is developed by me to create 2D and 3d applications

# Show case

![2](https://github.com/RodrigoPAml/MandelbrotFractal/assets/41243039/e5497c15-a1ee-498c-972b-377a6b18c9ac)

Fractal below have the credits to https://www.shadertoy.com/view/tllSWj

![222](https://github.com/RodrigoPAml/MandelbrotFractal/assets/41243039/f0cdc027-e9da-4c5c-a3c9-d00d14629f50)

# How to use

- Space/Z to zoom in/out
- Q to change between fractals variants

# Implementation

The Mandelbrot set is a collection of points in the complex plane. Each point \(c\) is a complex number represented as \(c = x + yi\) (where \(x\) and \(y\) are real numbers, and \(i\) is the imaginary unit).

To check if a point \(c\) is in the Mandelbrot set, we repeatedly apply a formula and see if the result gets very large (tends to infinity). If it does, the point is not in the set. If it doesn't, the point is in the set.

Here's the basic GLSL code that does this:
```glsl
    for (int i = 0; i < max_iterations; i++) 
    {
        if (length(z) > 8.0) {
            break;
        }
        
        z = vec2(z.x * z.x - z.y * z.y, 2.0 * z.x * z.y) + c; // iteration formula
        
        iterations++;
    }

    if (iterations == max_iterations || iterations == 0) 
    {
        fragColor = vec4(0, 0 , 0, 1.0); // outside
    }
    else
    {
        fragColor = (float(iterations)/float(max_iterations)); // inside
    }
```

# Executing

- Box Engine is available in Engine Folders with a release and the source code is in my repository (note that versions might differ)
- To run use start.sh or use start_editor.sh to use the engine editor and change settings better
- The complete source code of the fractal is in Assets folder

![image](https://github.com/RodrigoPAml/MandelbrotFractal/assets/41243039/0cef1d04-8c36-43b3-9019-a067cbdf1765)

