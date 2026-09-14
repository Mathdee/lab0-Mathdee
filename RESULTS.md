# Lab 0 results

Name:  Mathijs Deelen
Student number:  33310434
Lab section:  L01

## Which environment did you use?

Tick one, and say how many cores it reported:

- [ ] GitHub Codespaces — cores: REPLACE THIS LINE
- [ ] Docker or Podman on my own laptop — OS and cores: REPLACE THIS LINE
- [ ] An SCI 234 lab machine — cores: REPLACE THIS LINE
- [X] Something else — Google Colab: 2

## Tools and sources

Tools and sources: REPLACE THIS LINE

> Required on every lab. For Lab 0 you **may** use AI to help with installation
> and setup problems — just say so here, e.g. "used Claude to work out why Docker
> Desktop would not start on Windows 11". From Lab 1 onward the restriction
> applies to the code you write, never to the toolchain.

## Two baseline runs

Run it twice, with a gap of a minute or two, and paste both:

```C
n = 10000000, 5 repeats
  run 0: 0.009600 s
  run 1: 0.009747 s
  run 2: 0.009657 s
  run 3: 0.009592 s
  run 4: 0.010551 s
best  0.009592 s
worst 0.010551 s
mean  0.009829 s
spread 10.0% of best
```

```C
n = 10000000, 5 repeats
  run 0: 0.009614 s
  run 1: 0.009651 s
  run 2: 0.010030 s
  run 3: 0.009719 s
  run 4: 0.009732 s
best  0.009614 s
worst 0.010030 s
mean  0.009749 s
spread 4.3% of best
```

## What you noticed

**0.1** What spread did you get between the fastest and slowest run of
*identical* work? Give the percentage.

- The first run I got a spread of 10%, on the second run I got a spread of 4.3%.

**0.2** Suppose in Lab 4 you measure a parallel version and it comes out 4%
faster than the serial one. Based on your spread above, would you believe it?
One sentence.

 - I would not believe it, as see above, I got a 4% faster best and it was the exact same code.

**0.3** Anything that went wrong during setup, and what fixed it. One or two
lines — this genuinely helps us fix the instructions for next year.

 - Nothing went wrong, 
