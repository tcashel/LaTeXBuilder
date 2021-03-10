# LaTeXBuilder

[![language][badge.language]][language]
[![license][badge.license]][license]

An easy way to build a LaTex file

## Overview

- This project contains the framework to build and release a LaTeX document using github workflows using a docker container as the build environment.
- You could use this to build a resume.
  - git tracking with versioned releases? yes please!
- The project uses `latexmk` to build and `texlive` for dependencies.
- Licensed under the Apache License, Version 2.0

## Usage

Ensure you have docker on your host machine, this project uses `docker-compose` to create an image and a `makefile` to build.

### Create the environment and Build

Spin up the docker image with

```bash
make docker-up
```

and build with

```bash
make docker-build
```

All build artifacts and the compiled PDF are in the `build` directory.

### Other Commands

See `make help` and look in the [makefile](./makefile) for more commands.

## Using the Workflows

### [Build LaTex Document](./.github/workflows/Build_and_Save.yml)

This workflow is run on any push or pull request to the main branch, it builds the `main.tex` file and saves the pdf as an artifact on the job.

### [Create Release Draft](./.github/workflows/release.yml)

This workflow is run on push events with tags matching the pattern `v*`, i.e. `v1.0`, `v2015.10`.  The job builds the pdf from `main.tex`, creates a draft release with [ReleaseNotes.md](./ReleaseNotes.md) in the body of the release and saves the pdf as `MainFile_v<tag value here>.pdf`. To change the root name see line 50 in [.github/workflows/release.yml](./.github/workflows/release.yml).

#### Git Tag Refresher

To Tag a commit, push up your changes, wait for the build jobs to pass and then:

```bash
git tag -a v2021.1 -m "version 2021.1"
```

then you can push the tag with:

```bash
git push origin v2021.1
```

see the git docs on tagging for more info: [Git Basics Tagging](https://git-scm.com/book/en/v2/Git-Basics-Tagging)

## Sources / References

The example resume in [main.tex](./main.tex) is from a [post on toofishes.net on May 10th 2010](https://web.archive.org/web/20151031150425/http://www.toofishes.net/blog/latex-resume-follow-up/)

The [.gitignore](./.gitignore) file is a trimmed down version of the [TeX.gitignore](https://github.com/github/gitignore/blob/master/TeX.gitignore) from the [gitignore](https://github.com/github/gitignore) project on GitHub.

## Support / Issues

File bug reports, feature requests and questions using [GitHub Issues](https://github.com/tcashel/LaTeXBuilder/issues)

[badge.language]: https://img.shields.io/badge/Language-LaTeX-yellow.svg
[badge.license]: https://img.shields.io/badge/license-Apache--2.0-blue

[language]: https://en.wikipedia.org/wiki/TeX
[license]: https://en.wikipedia.org/wiki/Apache_License