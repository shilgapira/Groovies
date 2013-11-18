# Groovies

A collection of patterns and additions that simplify iOS app development.


## Goals

- Provide solid abstractions for common patterns (e.g., assertions, styling, analytics, etc)
- Reduce boilerplate code for common tasks
- Extend language and SDK functionality


## Constraints

- Avoid bloat by ensuring features are useful to mostly any app from any domain
- Interfaces should be idiomatic as much as possible
- Leverage existing third party libraries where appropriate
- It should be trivial to fork and keep only a subset of the functionality
- Require iOS 6.0 deployment target


## Status

Groovies is very much a work in progress, though most existing functionality has undergone extensive functional testing. Assume that anything might be changed or removed for now.

Some open issues are:

- Add OS X support where possible
- Plenty of things are missing unit tests
- A few categories are quite redundant and should probably be removed
- Add or update documentation to work with Clang/Xcode 5's comment parsing
