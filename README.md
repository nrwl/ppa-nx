# Nx PPA

This project is used to publish packages tor the Nx PPA. It currently publishes the `nx` package, which is a wrapper for our Nx CLI, which requires Node.js.

PPA: https://launchpad.net/~nrwl/+archive/ubuntu/nx/+packages

## Guideline

Since the Nx wrapper is just the global installation, we do not need to publish every version of Nx to it. Generally, we keep the package in PPA one minor version behind latest NPM version.

## Publishing new versions

Go to [https://github.com/nrwl/ppa-nx/actions/workflows/publish.yml](https://github.com/nrwl/ppa-nx/actions/workflows/publish.yml) and use `Run workflow`. Fill in the Nx version that matches the version published to NPM registry.

Once the workflow is finished, the package will be validated on Launchpad. If successful, it'll be published in the PPA and be available to use.

