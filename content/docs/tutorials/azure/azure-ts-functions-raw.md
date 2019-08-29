---
title: "Azure Functions"
---

<a href="https://app.pulumi.com/new?template=https://github.com/pulumi/examples/tree/master/azure-ts-functions-raw" target="_blank">
    <img src="https://get.pulumi.com/new/button.svg" alt="Deploy" style="float: right; padding: 8px; margin-top: -65px; margin-right: 8px">
</a>

<p class="mb-4">
    <a class="btn btn-secondary" href="https://github.com/pulumi/examples/tree/master/azure-ts-functions-raw" target="_blank"><i class="fab fa-github pr-2"></i> VIEW CODE</a>
</p>


Azure Functions created from raw deployment packages in all supported languages.

.NET and Java are precompiled languages, and the deployment artifact contains compiled binaries. You will need the following tools to build these projects:

- [.NET Core SDK](https://dotnet.microsoft.com/download) for the .NET Function App
- [Apache Maven](https://maven.apache.org/) for the Java Function App

Please remove the corresponding resources from the program in case you don't need those runtimes.

Known issue: [#2784](https://github.com/pulumi/pulumi/issues/2784)&mdash;Python deployment package gets corrupted if deployed from Windows. Workaround: deploy from WSL (Windows Subsystem for Linux), Mac OS, or Linux.

## Running the App

1.  Build and publish the .NET Function App project:

    ```
    $ dotnet publish dotnet
    ```

1.  Build and publish the Java Function App project:

    ```
    $ mvn clean package -f java
    ```

1.  Create a new stack:

    ```
    $ pulumi stack init dev
    ```

1.  Login to Azure CLI (you will be prompted to do this during deployment if you forget this step):

    ```
    $ az login
    ```

1.  Restore NPM dependencies:

    ```
    $ npm install
    ```

1.  Configure the location to deploy the resources to:

    ```
    $ pulumi config set azure:location <location>
    ```

1.  Run `pulumi up` to preview and deploy changes:

    ```
    $ pulumi up
    Previewing update (dev):
    ...

    Updating (dev):
    ...
    Resources:
        + 33 created
    Duration: 2m42s
    ```

1.  Check the deployed function endpoints:

    ```
    $ pulumi stack output dotnetEndpoint
    https://http-dotnet1a2d3e4d.azurewebsites.net/api/HelloDotnet?name=Pulumi
    $ curl "$(pulumi stack output dotnetEndpoint)"
    Hello from .NET, Pulumi
    ```
