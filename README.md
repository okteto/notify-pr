# GitHub Actions for Okteto Cloud

## Automate your development workflows using Github Actions and Okteto Cloud
GitHub Actions gives you the flexibility to build an automated software development workflows. With GitHub Actions for Okteto Cloud you can create workflows to build, deploy and update your applications in [Okteto Cloud](https://cloud.okteto.com).

Get started today with a [free Okteto Cloud account](https://cloud.okteto.com)!

# Github action to notify a PR when a preview environment is ready

You can use this action to share the URL of the preview environment on a PR.

You can use this action to enable your CI/CD workflow in [Okteto Cloud](https://cloud.okteto.com).

[This document](https://okteto.com/docs/tutorials/getting-started-with-pipelines/index.html) has more information on this workflow.

## Inputs

### `message`

The message to send to the PR

## Environment variables

### `CUSTOM_CERTIFICATE`

The self-signed certificate of your environment. Best set on global level when using multiple Okteto actions.

# Example usage

This example runs the login action, activates a namespace, and triggers the Okteto pipeline

```yaml
# File: .github/workflows/workflow.yml
on:
  pull_request:
    branches:
      - master

name: example

jobs:
  devflow:
    runs-on: ubuntu-latest
    steps:
    - name: checkout
      uses: actions/checkout@master    

    - name: Login
      uses: okteto/login@master
      with:
        token: ${{ secrets.OKTETO_TOKEN }}

    - name: "Activate Namespace"
      uses: okteto/namespace@master
      with:
        name: cindylopez
    
    - name: "Trigger the pipeline"
      uses: okteto/pipeline@master
      with:
        name: pr-${{ github.event.number }}
        timeout: 8m
    
    - name: comment PR
      uses: okteto/notify-pr@master
      env:
        GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
      with:
        msg: "Preview environment available at https://movies-pr-${{ github.event.number }}-cindylopez.cloud.okteto.net"
```
