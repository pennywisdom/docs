
---
title: "GetGroup"
title_tag: "Function GetGroup | Module Identities | Package azuredevops"
meta_desc: "Explore the GetGroup function of the Identities module, including examples, input properties, output properties, and supporting types. Use this data source to access information about an existing Group within Azure DevOps"
---



<!-- WARNING: this file was generated by Pulumi Docs Generator. -->
<!-- Do not edit by hand unless you're certain you know what you are doing! -->

Use this data source to access information about an existing Group within Azure DevOps


## Relevant Links

* [Azure DevOps Service REST API 5.1 - Groups - Get](https://docs.microsoft.com/en-us/rest/api/azure/devops/graph/groups/get?view=azure-devops-rest-5.1)

{{% examples %}}
## Example Usage

{{< chooser language "typescript,python,go,csharp" / >}}

{{% example csharp %}}
```csharp
using Pulumi;
using AzureDevOps = Pulumi.AzureDevOps;

class MyStack : Stack
{
    public MyStack()
    {
        var project = Output.Create(AzureDevOps.Core.GetProject.InvokeAsync(new AzureDevOps.Core.GetProjectArgs
        {
            ProjectName = "contoso-project",
        }));
        var test = project.Apply(project => Output.Create(AzureDevOps.Identities.GetGroup.InvokeAsync(new AzureDevOps.Identities.GetGroupArgs
        {
            ProjectId = project.Id,
            Name = "Test Group",
        })));
        this.GroupId = test.Apply(test => test.Id);
        this.GroupDescriptor = test.Apply(test => test.Descriptor);
    }

    [Output("groupId")]
    public Output<string> GroupId { get; set; }
    [Output("groupDescriptor")]
    public Output<string> GroupDescriptor { get; set; }
}
```
{{% /example %}}

{{% example go %}}
```go
package main

import (
	"github.com/pulumi/pulumi/sdk/v2/go/pulumi"
)

func main() {
	pulumi.Run(func(ctx *pulumi.Context) error {
		project, err := Core.LookupProject(ctx, &Core.LookupProjectArgs{
			ProjectName: "contoso-project",
		}, nil)
		if err != nil {
			return err
		}
		test, err := Identities.LookupGroup(ctx, &Identities.LookupGroupArgs{
			ProjectId: project.Id,
			Name:      "Test Group",
		}, nil)
		if err != nil {
			return err
		}
		ctx.Export("groupId", test.Id)
		ctx.Export("groupDescriptor", test.Descriptor)
		return nil
	})
}
```
{{% /example %}}

{{% example python %}}
```python
import pulumi
import pulumi_azuredevops as azuredevops

project = azuredevops.Core.get_project(project_name="contoso-project")
test = azuredevops.Identities.get_group(project_id=project.id,
    name="Test Group")
pulumi.export("groupId", test.id)
pulumi.export("groupDescriptor", test.descriptor)
```
{{% /example %}}

{{% example typescript %}}
```typescript
import * as pulumi from "@pulumi/pulumi";
import * as azuredevops from "@pulumi/azuredevops";

const project = azuredevops.Core.getProject({
    projectName: "contoso-project",
});
const test = project.then(project => azuredevops.Identities.getGroup({
    projectId: project.id,
    name: "Test Group",
}));
export const groupId = test.then(test => test.id);
export const groupDescriptor = test.then(test => test.descriptor);
```
{{% /example %}}

{{% /examples %}}


## Using GetGroup {#using}

{{< chooser language "typescript,python,go,csharp" / >}}


{{% choosable language nodejs %}}
<div class="highlight"><pre class="chroma"><code class="language-typescript" data-lang="typescript"><span class="k">function </span>getGroup<span class="p">(</span><span class="nx">args</span><span class="p">:</span> <span class="nx"><a href="/docs/reference/pkg/nodejs/pulumi/azuredevops/Identities/#GetGroupArgs">GetGroupArgs</a></span><span class="p">, </span><span class="nx">opts</span><span class="p">?:</span> <span class="nx"><a href="/docs/reference/pkg/nodejs/pulumi/pulumi/#InvokeOptions">InvokeOptions</a></span><span class="p">): Promise&lt;<span class="nx"><a href="/docs/reference/pkg/nodejs/pulumi/azuredevops/Identities/#GetGroupResult">GetGroupResult</a></span>></span></code></pre></div>
{{% /choosable %}}


{{% choosable language python %}}
<div class="highlight"><pre class="chroma"><code class="language-python" data-lang="python"><span class="k">function </span> get_group(</span>name=None<span class="p">, </span>project_id=None<span class="p">, </span>opts=None<span class="p">)</span></code></pre></div>
{{% /choosable %}}


{{% choosable language go %}}
<div class="highlight"><pre class="chroma"><code class="language-go" data-lang="go"><span class="k">func </span>LookupGroup<span class="p">(</span><span class="nx">ctx</span><span class="p"> *</span><span class="nx"><a href="https://pkg.go.dev/github.com/pulumi/pulumi/sdk/v2/go/pulumi?tab=doc#Context">Context</a></span><span class="p">, </span><span class="nx">args</span><span class="p"> *</span><span class="nx"><a href="https://pkg.go.dev/github.com/pulumi/pulumi-azuredevops/sdk/go/azuredevops/Identities?tab=doc#LookupGroupArgs">LookupGroupArgs</a></span><span class="p">, </span><span class="nx">opts</span><span class="p"> ...</span><span class="nx"><a href="https://pkg.go.dev/github.com/pulumi/pulumi/sdk/v2/go/pulumi?tab=doc#InvokeOption">InvokeOption</a></span><span class="p">) (*<span class="nx"><a href="https://pkg.go.dev/github.com/pulumi/pulumi-azuredevops/sdk/go/azuredevops/Identities?tab=doc#LookupGroupResult">LookupGroupResult</a></span>, error)</span></code></pre></div>

> Note: This function is named `LookupGroup` in the Go SDK.

{{% /choosable %}}


{{% choosable language csharp %}}
<div class="highlight"><pre class="chroma"><code class="language-csharp" data-lang="csharp"><span class="k">public static class </span><span class="nx">GetGroup </span><span class="p">{</span><span class="k">
    public static </span>Task&lt;<span class="nx"><a href="/docs/reference/pkg/dotnet/Pulumi.AzureDevOps/Pulumi.AzureDevOps.Identities.GetGroupResult.html">GetGroupResult</a></span>> <span class="p">InvokeAsync(</span><span class="nx"><a href="/docs/reference/pkg/dotnet/Pulumi.AzureDevOps/Pulumi.AzureDevOps.Identities.GetGroupArgs.html">GetGroupArgs</a></span><span class="p"> </span><span class="nx">args<span class="p">, </span><span class="nx"><a href="/docs/reference/pkg/dotnet/Pulumi/Pulumi.InvokeOptions.html">InvokeOptions</a></span><span class="p">? </span><span class="nx">opts = null<span class="p">)</span><span class="p">
}</span></code></pre></div>
{{% /choosable %}}



The following arguments are supported:



{{% choosable language csharp %}}
<dl class="resources-properties">

    <dt class="property-required"
            title="Required">
        <span id="name_csharp">
<a href="#name_csharp" style="color: inherit; text-decoration: inherit;">Name</a>
</span> 
        <span class="property-indicator"></span>
        <span class="property-type"><a href="https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/builtin-types/built-in-types">string</a></span>
    </dt>
    <dd>{{% md %}}The Group Name.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span id="projectid_csharp">
<a href="#projectid_csharp" style="color: inherit; text-decoration: inherit;">Project<wbr>Id</a>
</span> 
        <span class="property-indicator"></span>
        <span class="property-type"><a href="https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/builtin-types/built-in-types">string</a></span>
    </dt>
    <dd>{{% md %}}The Project Id.
{{% /md %}}</dd>

</dl>
{{% /choosable %}}


{{% choosable language go %}}
<dl class="resources-properties">

    <dt class="property-required"
            title="Required">
        <span id="name_go">
<a href="#name_go" style="color: inherit; text-decoration: inherit;">Name</a>
</span> 
        <span class="property-indicator"></span>
        <span class="property-type"><a href="https://golang.org/pkg/builtin/#string">string</a></span>
    </dt>
    <dd>{{% md %}}The Group Name.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span id="projectid_go">
<a href="#projectid_go" style="color: inherit; text-decoration: inherit;">Project<wbr>Id</a>
</span> 
        <span class="property-indicator"></span>
        <span class="property-type"><a href="https://golang.org/pkg/builtin/#string">string</a></span>
    </dt>
    <dd>{{% md %}}The Project Id.
{{% /md %}}</dd>

</dl>
{{% /choosable %}}


{{% choosable language nodejs %}}
<dl class="resources-properties">

    <dt class="property-required"
            title="Required">
        <span id="name_nodejs">
<a href="#name_nodejs" style="color: inherit; text-decoration: inherit;">name</a>
</span> 
        <span class="property-indicator"></span>
        <span class="property-type"><a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/string">string</a></span>
    </dt>
    <dd>{{% md %}}The Group Name.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span id="projectid_nodejs">
<a href="#projectid_nodejs" style="color: inherit; text-decoration: inherit;">project<wbr>Id</a>
</span> 
        <span class="property-indicator"></span>
        <span class="property-type"><a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/string">string</a></span>
    </dt>
    <dd>{{% md %}}The Project Id.
{{% /md %}}</dd>

</dl>
{{% /choosable %}}


{{% choosable language python %}}
<dl class="resources-properties">

    <dt class="property-required"
            title="Required">
        <span id="name_python">
<a href="#name_python" style="color: inherit; text-decoration: inherit;">name</a>
</span> 
        <span class="property-indicator"></span>
        <span class="property-type"><a href="https://docs.python.org/3/library/stdtypes.html">str</a></span>
    </dt>
    <dd>{{% md %}}The Group Name.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span id="project_id_python">
<a href="#project_id_python" style="color: inherit; text-decoration: inherit;">project_<wbr>id</a>
</span> 
        <span class="property-indicator"></span>
        <span class="property-type"><a href="https://docs.python.org/3/library/stdtypes.html">str</a></span>
    </dt>
    <dd>{{% md %}}The Project Id.
{{% /md %}}</dd>

</dl>
{{% /choosable %}}








## GetGroup Result {#result}

The following output properties are available:




{{% choosable language csharp %}}
<dl class="resources-properties">

    <dt class="property-"
            title="">
        <span id="descriptor_csharp">
<a href="#descriptor_csharp" style="color: inherit; text-decoration: inherit;">Descriptor</a>
</span> 
        <span class="property-indicator"></span>
        <span class="property-type"><a href="https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/builtin-types/built-in-types">string</a></span>
    </dt>
    <dd>{{% md %}}The Descriptor is the primary way to reference the graph subject. This field will uniquely identify the same graph subject across both Accounts and Organizations.
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span id="id_csharp">
<a href="#id_csharp" style="color: inherit; text-decoration: inherit;">Id</a>
</span> 
        <span class="property-indicator"></span>
        <span class="property-type"><a href="https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/builtin-types/built-in-types">string</a></span>
    </dt>
    <dd>{{% md %}}The provider-assigned unique ID for this managed resource.
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span id="name_csharp">
<a href="#name_csharp" style="color: inherit; text-decoration: inherit;">Name</a>
</span> 
        <span class="property-indicator"></span>
        <span class="property-type"><a href="https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/builtin-types/built-in-types">string</a></span>
    </dt>
    <dd>{{% md %}}{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span id="projectid_csharp">
<a href="#projectid_csharp" style="color: inherit; text-decoration: inherit;">Project<wbr>Id</a>
</span> 
        <span class="property-indicator"></span>
        <span class="property-type"><a href="https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/builtin-types/built-in-types">string</a></span>
    </dt>
    <dd>{{% md %}}{{% /md %}}</dd>

</dl>
{{% /choosable %}}


{{% choosable language go %}}
<dl class="resources-properties">

    <dt class="property-"
            title="">
        <span id="descriptor_go">
<a href="#descriptor_go" style="color: inherit; text-decoration: inherit;">Descriptor</a>
</span> 
        <span class="property-indicator"></span>
        <span class="property-type"><a href="https://golang.org/pkg/builtin/#string">string</a></span>
    </dt>
    <dd>{{% md %}}The Descriptor is the primary way to reference the graph subject. This field will uniquely identify the same graph subject across both Accounts and Organizations.
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span id="id_go">
<a href="#id_go" style="color: inherit; text-decoration: inherit;">Id</a>
</span> 
        <span class="property-indicator"></span>
        <span class="property-type"><a href="https://golang.org/pkg/builtin/#string">string</a></span>
    </dt>
    <dd>{{% md %}}The provider-assigned unique ID for this managed resource.
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span id="name_go">
<a href="#name_go" style="color: inherit; text-decoration: inherit;">Name</a>
</span> 
        <span class="property-indicator"></span>
        <span class="property-type"><a href="https://golang.org/pkg/builtin/#string">string</a></span>
    </dt>
    <dd>{{% md %}}{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span id="projectid_go">
<a href="#projectid_go" style="color: inherit; text-decoration: inherit;">Project<wbr>Id</a>
</span> 
        <span class="property-indicator"></span>
        <span class="property-type"><a href="https://golang.org/pkg/builtin/#string">string</a></span>
    </dt>
    <dd>{{% md %}}{{% /md %}}</dd>

</dl>
{{% /choosable %}}


{{% choosable language nodejs %}}
<dl class="resources-properties">

    <dt class="property-"
            title="">
        <span id="descriptor_nodejs">
<a href="#descriptor_nodejs" style="color: inherit; text-decoration: inherit;">descriptor</a>
</span> 
        <span class="property-indicator"></span>
        <span class="property-type"><a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/string">string</a></span>
    </dt>
    <dd>{{% md %}}The Descriptor is the primary way to reference the graph subject. This field will uniquely identify the same graph subject across both Accounts and Organizations.
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span id="id_nodejs">
<a href="#id_nodejs" style="color: inherit; text-decoration: inherit;">id</a>
</span> 
        <span class="property-indicator"></span>
        <span class="property-type"><a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/string">string</a></span>
    </dt>
    <dd>{{% md %}}The provider-assigned unique ID for this managed resource.
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span id="name_nodejs">
<a href="#name_nodejs" style="color: inherit; text-decoration: inherit;">name</a>
</span> 
        <span class="property-indicator"></span>
        <span class="property-type"><a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/string">string</a></span>
    </dt>
    <dd>{{% md %}}{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span id="projectid_nodejs">
<a href="#projectid_nodejs" style="color: inherit; text-decoration: inherit;">project<wbr>Id</a>
</span> 
        <span class="property-indicator"></span>
        <span class="property-type"><a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/string">string</a></span>
    </dt>
    <dd>{{% md %}}{{% /md %}}</dd>

</dl>
{{% /choosable %}}


{{% choosable language python %}}
<dl class="resources-properties">

    <dt class="property-"
            title="">
        <span id="descriptor_python">
<a href="#descriptor_python" style="color: inherit; text-decoration: inherit;">descriptor</a>
</span> 
        <span class="property-indicator"></span>
        <span class="property-type"><a href="https://docs.python.org/3/library/stdtypes.html">str</a></span>
    </dt>
    <dd>{{% md %}}The Descriptor is the primary way to reference the graph subject. This field will uniquely identify the same graph subject across both Accounts and Organizations.
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span id="id_python">
<a href="#id_python" style="color: inherit; text-decoration: inherit;">id</a>
</span> 
        <span class="property-indicator"></span>
        <span class="property-type"><a href="https://docs.python.org/3/library/stdtypes.html">str</a></span>
    </dt>
    <dd>{{% md %}}The provider-assigned unique ID for this managed resource.
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span id="name_python">
<a href="#name_python" style="color: inherit; text-decoration: inherit;">name</a>
</span> 
        <span class="property-indicator"></span>
        <span class="property-type"><a href="https://docs.python.org/3/library/stdtypes.html">str</a></span>
    </dt>
    <dd>{{% md %}}{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span id="project_id_python">
<a href="#project_id_python" style="color: inherit; text-decoration: inherit;">project_<wbr>id</a>
</span> 
        <span class="property-indicator"></span>
        <span class="property-type"><a href="https://docs.python.org/3/library/stdtypes.html">str</a></span>
    </dt>
    <dd>{{% md %}}{{% /md %}}</dd>

</dl>
{{% /choosable %}}









<h2 id="package-details">Package Details</h2>
<dl class="package-details">
	<dt>Repository</dt>
	<dd><a href="https://github.com/pulumi/pulumi-azuredevops">https://github.com/pulumi/pulumi-azuredevops</a></dd>
	<dt>License</dt>
	<dd>Apache-2.0</dd>
	<dt>Notes</dt>
	<dd>This Pulumi package is based on the [`azuredevops` Terraform Provider](https://github.com/terraform-providers/terraform-provider-azuredevops).</dd>
</dl>

