# COSC 407 / 507 — Lab 0: get a working toolchain

Do this in the week of 14 September, before your Lab 1 session.

Lab 0 is marked for completion only. It exists so that you never spend Lab 1 installing a compiler. Every later lab is done and submitted inside the two-hour lab period, and there is no time in that period to fix a broken environment.

You may use AI freely for this lab, including for installation problems. The no-AI rule that starts in Lab 1 is about the concurrency code you write, not about making a container start.

## Pick one of these four. The first is easiest.

### 1. GitHub Codespaces — nothing to install

First, get **your own copy** of this repo.

Go to https://github.com/cosc407/lab0 and click the green **"Use this template"** button, then **"Create a new repository."** Name it something like `lab0-<your-username>`. Choose **Private** so your submission isn't visible to classmates.

This creates your own separate repository — **you now own it and can push to it freely**. There is no ongoing link back to `cosc407/lab0`.

Then open your new repository in Codespaces:

**Code → Codespaces → Create codespace on main**

Wait a couple of minutes for the container to build the first time. You get VS Code in your browser with the whole toolchain ready.

Works on Windows, macOS and Chromebooks. As a verified student you get 180 Codespaces core-hours a month free with the Student Developer Pack. Stop your codespace when you finish — it bills by wall-clock time, not by whether you are typing.

### 2. Google Colab — no local installation

If you do not want to install Docker, Podman, or the course toolchain on your computer, you can use **Google Colab**.

Open:

https://colab.research.google.com/

Create a new notebook and run:

```bash
!git clone https://github.com/cosc407/lab0.git
%cd lab0
```

Check that the required tools are available:

```bash
!gcc --version
!make --version
```

You should then be able to build and run the lab:

```bash
!make
!./baseline 10000000 5
!make test
```

You can inspect your results with:

```bash
!cat RESULTS.md
```

#### Working with your own repository

The `cosc407/lab0` repository is the **template**. Your completed work should be kept in **your own GitHub repository**, created using the instructions in the Codespaces section above.

If you are using Colab, you have two options:

1. Clone your own repository instead of the template:

```bash
!git clone https://github.com/<your-username>/<your-lab0-repository>.git
%cd <your-lab0-repository>
```

2. Alternatively, download your completed files from Colab and commit them to your own repository using GitHub or Git on your computer.

**Do not push your work to `cosc407/lab0`.** That repository is the course template.

#### Important note about timing

Colab runs your code on shared virtualized hardware. Consequently, timing results can vary between sessions and are not directly comparable with results obtained on your laptop or the SCI 234 machines.

Colab is therefore fine for:

* getting the toolchain working;
* compiling and testing the lab;
* completing `RESULTS.md`;
* learning the Git workflow.

However, do not use Colab timing results to make performance comparisons with other students' machines.

### 3. Docker or Podman on your own laptop

Install Docker Desktop (free for enrolled students) or Podman Desktop, plus VS Code with the Dev Containers extension.

Clone **your own copy of the lab repository**, open it in VS Code, and accept **"Reopen in Container"**.

On an Apple Silicon Mac, make sure you are running the arm64 image and not amd64 under emulation — emulated timings are not comparable to anything, which matters in a course about measuring speed.

### 4. An SCI 234 lab machine

Use these if you have no laptop.

Check with your TA during Lab 0 week that the toolchain is present on the machines — **do not assume it is**.

You should still work from **your own copy of the repository**, not directly from `cosc407/lab0`.

---

## Then run this

From the root of your repository:

```bash
make
./baseline 10000000 5
make test
```

`make test` checks that gcc, make and pthreads all work, and that you have filled in `RESULTS.md`.

If it fails, sort it out this week, on the course forum (Canvas Discussions) if necessary.

---

## What you actually do

`src/baseline.c` is written for you — you do not write any C in Lab 0.

It sums 1…n on one thread several times and reports how much the timing varied between runs of identical work.

That spread is the whole point. From Lab 1 onward you will be claiming that one version of a program is faster than another. Such a claim means nothing until you know how much your own machine wobbles when nothing has changed at all.

Find out now.

Fill in `RESULTS.md` in **your own repository**, then commit and push your work to **your own repository**:

```bash
git add -A
git commit -m "Lab 0"
git push
```

**Do not push your work to the course template repository `cosc407/lab0`.**

---

## Repository ownership

For all work in this course:

* `cosc407/lab0` is the **course template**.
* Use **"Use this template"** to create your own repository.
* Your repository should be **private** unless instructed otherwise.
* Your completed work belongs in **your own repository**.
* Push changes to **your own GitHub repository**.
* Do not push or submit changes directly to the course template repository.
* Do not make your work publicly visible if that would allow other students to copy it.

Once you have created your own repository, all commands such as `git add`, `git commit`, and `git push` should operate on **your repository**.
