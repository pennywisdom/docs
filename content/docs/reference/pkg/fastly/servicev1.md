
---
title: "Servicev1"
block_external_search_index: true
---



Provides a Fastly Service, representing the configuration for a website, app,
API, or anything else to be served through Fastly. A Service encompasses Domains
and Backends.

The Service resource requires a domain name that is correctly set up to direct
traffic to the Fastly service. See Fastly's guide on [Adding CNAME Records][fastly-cname]
on their documentation site for guidance.

## Example Usage

Basic usage:

```typescript
import * as pulumi from "@pulumi/pulumi";
import * as fastly from "@pulumi/fastly";

const demo = new fastly.Servicev1("demo", {
    backends: [{
        address: "127.0.0.1",
        name: "localhost",
        port: 80,
    }],
    domains: [{
        comment: "demo",
        name: "demo.notexample.com",
    }],
    forceDestroy: true,
});
```

Basic usage with an Amazon S3 Website and that removes the `x-amz-request-id` header:

```typescript
import * as pulumi from "@pulumi/pulumi";
import * as aws from "@pulumi/aws";
import * as fastly from "@pulumi/fastly";

const website = new aws.s3.Bucket("website", {
    acl: "public-read",
    website: {
        errorDocument: "error.html",
        indexDocument: "index.html",
    },
});
const demo = new fastly.Servicev1("demo", {
    backends: [{
        address: "demo.notexample.com.s3-website-us-west-2.amazonaws.com",
        name: "AWS S3 hosting",
        port: 80,
    }],
    defaultHost: pulumi.interpolate`${website.name}.s3-website-us-west-2.amazonaws.com`,
    domains: [{
        comment: "demo",
        name: "demo.notexample.com",
    }],
    forceDestroy: true,
    gzips: [{
        contentTypes: [
            "text/html",
            "text/css",
        ],
        extensions: [
            "css",
            "js",
        ],
        name: "file extensions and content types",
    }],
    headers: [{
        action: "delete",
        destination: "http.x-amz-request-id",
        name: "remove x-amz-request-id",
        type: "cache",
    }],
});
```

Basic usage with [custom
VCL](https://docs.fastly.com/guides/vcl/uploading-custom-vcl) (must be
enabled on your Fastly account):

```typescript
import * as pulumi from "@pulumi/pulumi";
import * as fastly from "@pulumi/fastly";
import * as fs from "fs";

const demo = new fastly.Servicev1("demo", {
    backends: [{
        address: "127.0.0.1",
        name: "localhost",
        port: 80,
    }],
    domains: [{
        comment: "demo",
        name: "demo.notexample.com",
    }],
    forceDestroy: true,
    vcls: [
        {
            content: fs.readFileSync(`./my_custom_main.vcl`, "utf-8"),
            main: true,
            name: "my_custom_main_vcl",
        },
        {
            content: fs.readFileSync(`./my_custom_library.vcl`, "utf-8"),
            name: "my_custom_library_vcl",
        },
    ],
});
```

Basic usage with [custom Director](https://docs.fastly.com/api/config#director):

```typescript
import * as pulumi from "@pulumi/pulumi";
import * as fastly from "@pulumi/fastly";

const demo = new fastly.Servicev1("demo", {
    backends: [
        {
            address: "127.0.0.1",
            name: "origin1",
            port: 80,
        },
        {
            address: "127.0.0.2",
            name: "origin2",
            port: 80,
        },
    ],
    directors: [{
        backends: [
            "origin1",
            "origin2",
        ],
        name: "mydirector",
        quorum: 0,
        type: 3,
    }],
    domains: [{
        comment: "demo",
        name: "demo.notexample.com",
    }],
    forceDestroy: true,
});
```

> **Note:** For an AWS S3 Bucket, the Backend address is
`<domain>.s3-website-<region>.amazonaws.com`. The `default_host` attribute
should be set to `<bucket_name>.s3-website-<region>.amazonaws.com`. See the
Fastly documentation on [Amazon S3][fastly-s3].

> This content is derived from https://github.com/terraform-providers/terraform-provider-fastly/blob/master/website/docs/r/service_v1.html.markdown.



## Create a Servicev1 Resource

{{< chooser language "javascript,typescript,python,go,csharp" / >}}

{{% choosable language nodejs %}}
<div class="highlight"><pre class="chroma"><code class="language-typescript" data-lang="typescript"><span class="k">new </span><span class="nx"><a href="/docs/reference/pkg/nodejs/pulumi/fastly/#Servicev1">Servicev1</a></span><span class="p">(</span><span class="nx">name</span>: <span class="nx"><a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/string">string</a></span><span class="p">, </span><span class="nx">args</span>: <span class="nx"><a href="/docs/reference/pkg/nodejs/pulumi/fastly/#Servicev1Args">Servicev1Args</a></span><span class="p">, </span><span class="nx">opts</span>?: <span class="nx"><a href="/docs/reference/pkg/nodejs/pulumi/pulumi/#CustomResourceOptions">pulumi.CustomResourceOptions</a></span><span class="p">);</span></code></pre></div>
{{% /choosable %}}

{{% choosable language python %}}
<div class="highlight"><pre class="chroma"><code class="language-python" data-lang="python"><span class="k">def </span><span class="nf">Servicev1</span><span class="p">(resource_name, opts=None, </span>acls=None<span class="p">, </span>activate=None<span class="p">, </span>backends=None<span class="p">, </span>bigqueryloggings=None<span class="p">, </span>blobstorageloggings=None<span class="p">, </span>cache_settings=None<span class="p">, </span>comment=None<span class="p">, </span>conditions=None<span class="p">, </span>default_host=None<span class="p">, </span>default_ttl=None<span class="p">, </span>dictionaries=None<span class="p">, </span>directors=None<span class="p">, </span>domains=None<span class="p">, </span>dynamicsnippets=None<span class="p">, </span>force_destroy=None<span class="p">, </span>gcsloggings=None<span class="p">, </span>gzips=None<span class="p">, </span>headers=None<span class="p">, </span>healthchecks=None<span class="p">, </span>logentries=None<span class="p">, </span>name=None<span class="p">, </span>papertrails=None<span class="p">, </span>request_settings=None<span class="p">, </span>response_objects=None<span class="p">, </span>s3loggings=None<span class="p">, </span>snippets=None<span class="p">, </span>splunks=None<span class="p">, </span>sumologics=None<span class="p">, </span>syslogs=None<span class="p">, </span>vcls=None<span class="p">, </span>version_comment=None<span class="p">, __props__=None);</span></code></pre></div>
{{% /choosable %}}

{{% choosable language go %}}
<div class="highlight"><pre class="chroma"><code class="language-go" data-lang="go"><span class="k">func </span>NewServicev1<span class="p">(</span><span class="nx">ctx</span> *<span class="nx"><a href="https://pkg.go.dev/github.com/pulumi/pulumi/sdk/go/pulumi?tab=doc#Context">pulumi.Context</a></span><span class="p">, </span><span class="nx">name</span> <span class="nx"><a href="https://golang.org/pkg/builtin/#string">string</a></span><span class="p">, </span><span class="nx">args</span> <span class="nx"><a href="https://pkg.go.dev/github.com/pulumi/pulumi-fastly/sdk/go/fastly/?tab=doc#Servicev1Args">Servicev1Args</a></span><span class="p">, </span><span class="nx">opts</span> ...<span class="nx"><a href="https://pkg.go.dev/github.com/pulumi/pulumi/sdk/go/pulumi?tab=doc#ResourceOption">pulumi.ResourceOption</a></span><span class="p">) (*<span class="nx"><a href="https://pkg.go.dev/github.com/pulumi/pulumi-fastly/sdk/go/fastly/?tab=doc#Servicev1">Servicev1</a></span>, error)</span></code></pre></div>
{{% /choosable %}}

{{% choosable language csharp %}}
<div class="highlight"><pre class="chroma"><code class="language-csharp" data-lang="csharp"><span class="k">public </span><span class="nx"><a href="/docs/reference/pkg/dotnet/Pulumi.Fastly/Pulumi.Fastly..Servicev1.html">Servicev1</a></span><span class="p">(</span><span class="nx"><a href="https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/builtin-types/built-in-types">string</a></span> <span class="nx">name<span class="p">, </span><span class="nx"><a href="/docs/reference/pkg/dotnet/Pulumi.Fastly/Pulumi.Fastly.Servicev1Args.html">Servicev1Args</a></span> <span class="nx">args<span class="p">, </span><span class="nx"><a href="/docs/reference/pkg/dotnet/Pulumi/Pulumi.CustomResourceOptions.html">CustomResourceOptions</a></span>? <span class="nx">opts = null<span class="p">)</span></code></pre></div>
{{% /choosable %}}

{{% choosable language nodejs %}}

<dl class="resources-properties">
    <dt class="property-required" title="Required">
        <span>name</span>
        <span class="property-indicator"></span>
    </dt>
    <dd>The unique name of the resource.</dd>
    <dt class="property-optional" title="Optional">
        <span>args</span>
        <span class="property-indicator"></span>
    </dt>
    <dd>The arguments to use to populate this resource's properties.</dd>
    <dt class="property-optional" title="Optional">
        <span>opts</span>
        <span class="property-indicator"></span>
    </dt>
    <dd>A bag of options that control this resource's behavior.</dd>
</dl>

{{% /choosable %}}

{{% choosable language python %}}
<dl class="resources-properties">
    <dt class="property-required" title="Required">
        <span>name</span>
        <span class="property-indicator"></span>
    </dt>
    <dd>The unique name of the resource.</dd>
    <dt class="property-optional" title="Optional">
        <span>opts</span>
        <span class="property-indicator"></span>
    </dt>
    <dd>A bag of options that control this resource's behavior.</dd>
</dl>
{{% /choosable %}}

{{% choosable language go %}}

<dl class="resources-properties">
    <dt class="property-required" title="Required">
        <span>name</span>
        <span class="property-indicator"></span>
    </dt>
    <dd>The unique name of the resource.</dd>
    <dt class="property-optional" title="Optional">
        <span>args</span>
        <span class="property-indicator"></span>
    </dt>
    <dd>The arguments to use to populate this resource's properties.</dd>
    <dt class="property-optional" title="Optional">
        <span>opts</span>
        <span class="property-indicator"></span>
    </dt>
    <dd>A bag of options that control this resource's behavior.</dd>
</dl>

{{% /choosable %}}

{{% choosable language csharp %}}

<dl class="resources-properties">
    <dt class="property-required" title="Required">
        <span>name</span>
        <span class="property-indicator"></span>
    </dt>
    <dd>The unique name of the resource.</dd>
    <dt class="property-optional" title="Optional">
        <span>args</span>
        <span class="property-indicator"></span>
    </dt>
    <dd>The arguments to use to populate this resource's properties.</dd>
    <dt class="property-optional" title="Optional">
        <span>opts</span>
        <span class="property-indicator"></span>
    </dt>
    <dd>A bag of options that control this resource's behavior.</dd>
</dl>

{{% /choosable %}}

#### Resource Arguments




{{% choosable language csharp %}}
<dl class="resources-properties">

    <dt class="property-optional"
            title="Optional">
        <span>Acls</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1acl">List&lt;Servicev1Acl<wbr>Args&gt;?</a></span>
    </dt>
    <dd>{{% md %}}A set of ACL configuration blocks.  Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Activate</span>
        <span class="property-indicator"></span>
        <span class="property-type">bool?</span>
    </dt>
    <dd>{{% md %}}Conditionally prevents the Service from being activated. The apply step will continue to create a new draft version but will not activate it if this is set to false. Default true.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Backends</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1backend">List&lt;Servicev1Backend<wbr>Args&gt;?</a></span>
    </dt>
    <dd>{{% md %}}A set of Backends to service requests from your Domains.
Defined below. Backends must be defined in this argument, or defined in the
`vcl` argument below
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Bigqueryloggings</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1bigquerylogging">List&lt;Servicev1Bigquerylogging<wbr>Args&gt;?</a></span>
    </dt>
    <dd>{{% md %}}A BigQuery endpoint to send streaming logs too.
Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Blobstorageloggings</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1blobstoragelogging">List&lt;Servicev1Blobstoragelogging<wbr>Args&gt;?</a></span>
    </dt>
    <dd>{{% md %}}An Azure Blob Storage endpoint to send streaming logs too.
Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Cache<wbr>Settings</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1cachesetting">List&lt;Servicev1Cache<wbr>Setting<wbr>Args&gt;?</a></span>
    </dt>
    <dd>{{% md %}}A set of Cache Settings, allowing you to override
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Comment</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}An optional comment about the Director.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Conditions</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1condition">List&lt;Servicev1Condition<wbr>Args&gt;?</a></span>
    </dt>
    <dd>{{% md %}}A set of conditions to add logic to any basic
configuration object in this service. Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Default<wbr>Host</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}Sets the host header.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Default<wbr>Ttl</span>
        <span class="property-indicator"></span>
        <span class="property-type">int?</span>
    </dt>
    <dd>{{% md %}}The default Time-to-live (TTL) for
requests.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Dictionaries</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1dictionary">List&lt;Servicev1Dictionary<wbr>Args&gt;?</a></span>
    </dt>
    <dd>{{% md %}}A set of dictionaries that allow the storing of key values pair for use within VCL functions. Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Directors</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1director">List&lt;Servicev1Director<wbr>Args&gt;?</a></span>
    </dt>
    <dd>{{% md %}}A director to allow more control over balancing traffic over backends.
when an item is not to be cached based on an above `condition`. Defined below
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>Domains</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1domain">List&lt;Servicev1Domain<wbr>Args&gt;</a></span>
    </dt>
    <dd>{{% md %}}If you created the S3 bucket outside of `us-east-1`,
then specify the corresponding bucket endpoint. Example: `s3-us-west-2.amazonaws.com`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Dynamicsnippets</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1dynamicsnippet">List&lt;Servicev1Dynamicsnippet<wbr>Args&gt;?</a></span>
    </dt>
    <dd>{{% md %}}A set of custom, "dynamic" VCL Snippet configuration blocks.  Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Force<wbr>Destroy</span>
        <span class="property-indicator"></span>
        <span class="property-type">bool?</span>
    </dt>
    <dd>{{% md %}}Services that are active cannot be destroyed. In
order to destroy the Service, set `force_destroy` to `true`. Default `false`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Gcsloggings</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1gcslogging">List&lt;Servicev1Gcslogging<wbr>Args&gt;?</a></span>
    </dt>
    <dd>{{% md %}}A gcs endpoint to send streaming logs too.
Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Gzips</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1gzip">List&lt;Servicev1Gzip<wbr>Args&gt;?</a></span>
    </dt>
    <dd>{{% md %}}A set of gzip rules to control automatic gzipping of
content. Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Headers</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1header">List&lt;Servicev1Header<wbr>Args&gt;?</a></span>
    </dt>
    <dd>{{% md %}}A set of Headers to manipulate for each request. Defined
below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Healthchecks</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1healthcheck">List&lt;Servicev1Healthcheck<wbr>Args&gt;?</a></span>
    </dt>
    <dd>{{% md %}}Name of a defined `healthcheck` to assign to this backend.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Logentries</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1logentry">List&lt;Servicev1Logentry<wbr>Args&gt;?</a></span>
    </dt>
    <dd>{{% md %}}A logentries endpoint to send streaming logs too.
Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Name</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}A unique name to identify this dictionary.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Papertrails</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1papertrail">List&lt;Servicev1Papertrail<wbr>Args&gt;?</a></span>
    </dt>
    <dd>{{% md %}}A Papertrail endpoint to send streaming logs too.
Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Request<wbr>Settings</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1requestsetting">List&lt;Servicev1Request<wbr>Setting<wbr>Args&gt;?</a></span>
    </dt>
    <dd>{{% md %}}A set of Request modifiers. Defined below
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Response<wbr>Objects</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1responseobject">List&lt;Servicev1Response<wbr>Object<wbr>Args&gt;?</a></span>
    </dt>
    <dd>{{% md %}}Allows you to create synthetic responses that exist entirely on the varnish machine. Useful for creating error or maintenance pages that exists outside the scope of your datacenter. Best when used with Condition objects.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>S3loggings</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1s3logging">List&lt;Servicev1S3logging<wbr>Args&gt;?</a></span>
    </dt>
    <dd>{{% md %}}A set of S3 Buckets to send streaming logs too.
Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Snippets</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1snippet">List&lt;Servicev1Snippet<wbr>Args&gt;?</a></span>
    </dt>
    <dd>{{% md %}}A set of custom, "regular" (non-dynamic) VCL Snippet configuration blocks.  Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Splunks</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1splunk">List&lt;Servicev1Splunk<wbr>Args&gt;?</a></span>
    </dt>
    <dd>{{% md %}}A Splunk endpoint to send streaming logs too.
Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Sumologics</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1sumologic">List&lt;Servicev1Sumologic<wbr>Args&gt;?</a></span>
    </dt>
    <dd>{{% md %}}A Sumologic endpoint to send streaming logs too.
Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Syslogs</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1syslog">List&lt;Servicev1Syslog<wbr>Args&gt;?</a></span>
    </dt>
    <dd>{{% md %}}A syslog endpoint to send streaming logs too.
Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Vcls</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1vcl">List&lt;Servicev1Vcl<wbr>Args&gt;?</a></span>
    </dt>
    <dd>{{% md %}}A set of custom VCL configuration blocks. The
ability to upload custom VCL code is not enabled by default for new Fastly
accounts (see the [Fastly documentation](https://docs.fastly.com/guides/vcl/uploading-custom-vcl) for details).
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Version<wbr>Comment</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}Description field for the version.
{{% /md %}}</dd>

</dl>
{{% /choosable %}}


{{% choosable language go %}}
<dl class="resources-properties">

    <dt class="property-optional"
            title="Optional">
        <span>Acls</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1acl">[]Servicev1Acl</a></span>
    </dt>
    <dd>{{% md %}}A set of ACL configuration blocks.  Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Activate</span>
        <span class="property-indicator"></span>
        <span class="property-type">*bool</span>
    </dt>
    <dd>{{% md %}}Conditionally prevents the Service from being activated. The apply step will continue to create a new draft version but will not activate it if this is set to false. Default true.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Backends</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1backend">[]Servicev1Backend</a></span>
    </dt>
    <dd>{{% md %}}A set of Backends to service requests from your Domains.
Defined below. Backends must be defined in this argument, or defined in the
`vcl` argument below
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Bigqueryloggings</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1bigquerylogging">[]Servicev1Bigquerylogging</a></span>
    </dt>
    <dd>{{% md %}}A BigQuery endpoint to send streaming logs too.
Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Blobstorageloggings</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1blobstoragelogging">[]Servicev1Blobstoragelogging</a></span>
    </dt>
    <dd>{{% md %}}An Azure Blob Storage endpoint to send streaming logs too.
Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Cache<wbr>Settings</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1cachesetting">[]Servicev1Cache<wbr>Setting</a></span>
    </dt>
    <dd>{{% md %}}A set of Cache Settings, allowing you to override
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Comment</span>
        <span class="property-indicator"></span>
        <span class="property-type">*string</span>
    </dt>
    <dd>{{% md %}}An optional comment about the Director.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Conditions</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1condition">[]Servicev1Condition</a></span>
    </dt>
    <dd>{{% md %}}A set of conditions to add logic to any basic
configuration object in this service. Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Default<wbr>Host</span>
        <span class="property-indicator"></span>
        <span class="property-type">*string</span>
    </dt>
    <dd>{{% md %}}Sets the host header.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Default<wbr>Ttl</span>
        <span class="property-indicator"></span>
        <span class="property-type">*int</span>
    </dt>
    <dd>{{% md %}}The default Time-to-live (TTL) for
requests.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Dictionaries</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1dictionary">[]Servicev1Dictionary</a></span>
    </dt>
    <dd>{{% md %}}A set of dictionaries that allow the storing of key values pair for use within VCL functions. Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Directors</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1director">[]Servicev1Director</a></span>
    </dt>
    <dd>{{% md %}}A director to allow more control over balancing traffic over backends.
when an item is not to be cached based on an above `condition`. Defined below
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>Domains</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1domain">[]Servicev1Domain</a></span>
    </dt>
    <dd>{{% md %}}If you created the S3 bucket outside of `us-east-1`,
then specify the corresponding bucket endpoint. Example: `s3-us-west-2.amazonaws.com`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Dynamicsnippets</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1dynamicsnippet">[]Servicev1Dynamicsnippet</a></span>
    </dt>
    <dd>{{% md %}}A set of custom, "dynamic" VCL Snippet configuration blocks.  Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Force<wbr>Destroy</span>
        <span class="property-indicator"></span>
        <span class="property-type">*bool</span>
    </dt>
    <dd>{{% md %}}Services that are active cannot be destroyed. In
order to destroy the Service, set `force_destroy` to `true`. Default `false`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Gcsloggings</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1gcslogging">[]Servicev1Gcslogging</a></span>
    </dt>
    <dd>{{% md %}}A gcs endpoint to send streaming logs too.
Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Gzips</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1gzip">[]Servicev1Gzip</a></span>
    </dt>
    <dd>{{% md %}}A set of gzip rules to control automatic gzipping of
content. Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Headers</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1header">[]Servicev1Header</a></span>
    </dt>
    <dd>{{% md %}}A set of Headers to manipulate for each request. Defined
below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Healthchecks</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1healthcheck">[]Servicev1Healthcheck</a></span>
    </dt>
    <dd>{{% md %}}Name of a defined `healthcheck` to assign to this backend.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Logentries</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1logentry">[]Servicev1Logentry</a></span>
    </dt>
    <dd>{{% md %}}A logentries endpoint to send streaming logs too.
Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Name</span>
        <span class="property-indicator"></span>
        <span class="property-type">*string</span>
    </dt>
    <dd>{{% md %}}A unique name to identify this dictionary.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Papertrails</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1papertrail">[]Servicev1Papertrail</a></span>
    </dt>
    <dd>{{% md %}}A Papertrail endpoint to send streaming logs too.
Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Request<wbr>Settings</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1requestsetting">[]Servicev1Request<wbr>Setting</a></span>
    </dt>
    <dd>{{% md %}}A set of Request modifiers. Defined below
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Response<wbr>Objects</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1responseobject">[]Servicev1Response<wbr>Object</a></span>
    </dt>
    <dd>{{% md %}}Allows you to create synthetic responses that exist entirely on the varnish machine. Useful for creating error or maintenance pages that exists outside the scope of your datacenter. Best when used with Condition objects.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>S3loggings</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1s3logging">[]Servicev1S3logging</a></span>
    </dt>
    <dd>{{% md %}}A set of S3 Buckets to send streaming logs too.
Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Snippets</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1snippet">[]Servicev1Snippet</a></span>
    </dt>
    <dd>{{% md %}}A set of custom, "regular" (non-dynamic) VCL Snippet configuration blocks.  Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Splunks</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1splunk">[]Servicev1Splunk</a></span>
    </dt>
    <dd>{{% md %}}A Splunk endpoint to send streaming logs too.
Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Sumologics</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1sumologic">[]Servicev1Sumologic</a></span>
    </dt>
    <dd>{{% md %}}A Sumologic endpoint to send streaming logs too.
Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Syslogs</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1syslog">[]Servicev1Syslog</a></span>
    </dt>
    <dd>{{% md %}}A syslog endpoint to send streaming logs too.
Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Vcls</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1vcl">[]Servicev1Vcl</a></span>
    </dt>
    <dd>{{% md %}}A set of custom VCL configuration blocks. The
ability to upload custom VCL code is not enabled by default for new Fastly
accounts (see the [Fastly documentation](https://docs.fastly.com/guides/vcl/uploading-custom-vcl) for details).
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Version<wbr>Comment</span>
        <span class="property-indicator"></span>
        <span class="property-type">*string</span>
    </dt>
    <dd>{{% md %}}Description field for the version.
{{% /md %}}</dd>

</dl>
{{% /choosable %}}


{{% choosable language nodejs %}}
<dl class="resources-properties">

    <dt class="property-optional"
            title="Optional">
        <span>acls</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1acl">Servicev1Acl[]?</a></span>
    </dt>
    <dd>{{% md %}}A set of ACL configuration blocks.  Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>activate</span>
        <span class="property-indicator"></span>
        <span class="property-type">boolean?</span>
    </dt>
    <dd>{{% md %}}Conditionally prevents the Service from being activated. The apply step will continue to create a new draft version but will not activate it if this is set to false. Default true.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>backends</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1backend">Servicev1Backend[]?</a></span>
    </dt>
    <dd>{{% md %}}A set of Backends to service requests from your Domains.
Defined below. Backends must be defined in this argument, or defined in the
`vcl` argument below
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>bigqueryloggings</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1bigquerylogging">Servicev1Bigquerylogging[]?</a></span>
    </dt>
    <dd>{{% md %}}A BigQuery endpoint to send streaming logs too.
Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>blobstorageloggings</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1blobstoragelogging">Servicev1Blobstoragelogging[]?</a></span>
    </dt>
    <dd>{{% md %}}An Azure Blob Storage endpoint to send streaming logs too.
Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>cache<wbr>Settings</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1cachesetting">Servicev1Cache<wbr>Setting[]?</a></span>
    </dt>
    <dd>{{% md %}}A set of Cache Settings, allowing you to override
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>comment</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}An optional comment about the Director.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>conditions</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1condition">Servicev1Condition[]?</a></span>
    </dt>
    <dd>{{% md %}}A set of conditions to add logic to any basic
configuration object in this service. Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>default<wbr>Host</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}Sets the host header.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>default<wbr>Ttl</span>
        <span class="property-indicator"></span>
        <span class="property-type">number?</span>
    </dt>
    <dd>{{% md %}}The default Time-to-live (TTL) for
requests.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>dictionaries</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1dictionary">Servicev1Dictionary[]?</a></span>
    </dt>
    <dd>{{% md %}}A set of dictionaries that allow the storing of key values pair for use within VCL functions. Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>directors</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1director">Servicev1Director[]?</a></span>
    </dt>
    <dd>{{% md %}}A director to allow more control over balancing traffic over backends.
when an item is not to be cached based on an above `condition`. Defined below
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>domains</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1domain">Servicev1Domain[]</a></span>
    </dt>
    <dd>{{% md %}}If you created the S3 bucket outside of `us-east-1`,
then specify the corresponding bucket endpoint. Example: `s3-us-west-2.amazonaws.com`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>dynamicsnippets</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1dynamicsnippet">Servicev1Dynamicsnippet[]?</a></span>
    </dt>
    <dd>{{% md %}}A set of custom, "dynamic" VCL Snippet configuration blocks.  Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>force<wbr>Destroy</span>
        <span class="property-indicator"></span>
        <span class="property-type">boolean?</span>
    </dt>
    <dd>{{% md %}}Services that are active cannot be destroyed. In
order to destroy the Service, set `force_destroy` to `true`. Default `false`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>gcsloggings</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1gcslogging">Servicev1Gcslogging[]?</a></span>
    </dt>
    <dd>{{% md %}}A gcs endpoint to send streaming logs too.
Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>gzips</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1gzip">Servicev1Gzip[]?</a></span>
    </dt>
    <dd>{{% md %}}A set of gzip rules to control automatic gzipping of
content. Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>headers</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1header">Servicev1Header[]?</a></span>
    </dt>
    <dd>{{% md %}}A set of Headers to manipulate for each request. Defined
below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>healthchecks</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1healthcheck">Servicev1Healthcheck[]?</a></span>
    </dt>
    <dd>{{% md %}}Name of a defined `healthcheck` to assign to this backend.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>logentries</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1logentry">Servicev1Logentry[]?</a></span>
    </dt>
    <dd>{{% md %}}A logentries endpoint to send streaming logs too.
Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>name</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}A unique name to identify this dictionary.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>papertrails</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1papertrail">Servicev1Papertrail[]?</a></span>
    </dt>
    <dd>{{% md %}}A Papertrail endpoint to send streaming logs too.
Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>request<wbr>Settings</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1requestsetting">Servicev1Request<wbr>Setting[]?</a></span>
    </dt>
    <dd>{{% md %}}A set of Request modifiers. Defined below
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>response<wbr>Objects</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1responseobject">Servicev1Response<wbr>Object[]?</a></span>
    </dt>
    <dd>{{% md %}}Allows you to create synthetic responses that exist entirely on the varnish machine. Useful for creating error or maintenance pages that exists outside the scope of your datacenter. Best when used with Condition objects.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>s3loggings</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1s3logging">Servicev1S3logging[]?</a></span>
    </dt>
    <dd>{{% md %}}A set of S3 Buckets to send streaming logs too.
Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>snippets</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1snippet">Servicev1Snippet[]?</a></span>
    </dt>
    <dd>{{% md %}}A set of custom, "regular" (non-dynamic) VCL Snippet configuration blocks.  Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>splunks</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1splunk">Servicev1Splunk[]?</a></span>
    </dt>
    <dd>{{% md %}}A Splunk endpoint to send streaming logs too.
Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>sumologics</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1sumologic">Servicev1Sumologic[]?</a></span>
    </dt>
    <dd>{{% md %}}A Sumologic endpoint to send streaming logs too.
Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>syslogs</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1syslog">Servicev1Syslog[]?</a></span>
    </dt>
    <dd>{{% md %}}A syslog endpoint to send streaming logs too.
Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>vcls</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1vcl">Servicev1Vcl[]?</a></span>
    </dt>
    <dd>{{% md %}}A set of custom VCL configuration blocks. The
ability to upload custom VCL code is not enabled by default for new Fastly
accounts (see the [Fastly documentation](https://docs.fastly.com/guides/vcl/uploading-custom-vcl) for details).
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>version<wbr>Comment</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}Description field for the version.
{{% /md %}}</dd>

</dl>
{{% /choosable %}}


{{% choosable language python %}}
<dl class="resources-properties">

    <dt class="property-optional"
            title="Optional">
        <span>acls</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1acl">List[Servicev1Acl]</a></span>
    </dt>
    <dd>{{% md %}}A set of ACL configuration blocks.  Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>activate</span>
        <span class="property-indicator"></span>
        <span class="property-type">bool</span>
    </dt>
    <dd>{{% md %}}Conditionally prevents the Service from being activated. The apply step will continue to create a new draft version but will not activate it if this is set to false. Default true.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>backends</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1backend">List[Servicev1Backend]</a></span>
    </dt>
    <dd>{{% md %}}A set of Backends to service requests from your Domains.
Defined below. Backends must be defined in this argument, or defined in the
`vcl` argument below
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>bigqueryloggings</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1bigquerylogging">List[Servicev1Bigquerylogging]</a></span>
    </dt>
    <dd>{{% md %}}A BigQuery endpoint to send streaming logs too.
Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>blobstorageloggings</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1blobstoragelogging">List[Servicev1Blobstoragelogging]</a></span>
    </dt>
    <dd>{{% md %}}An Azure Blob Storage endpoint to send streaming logs too.
Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>cache_<wbr>settings</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1cachesetting">List[Servicev1Cache<wbr>Setting]</a></span>
    </dt>
    <dd>{{% md %}}A set of Cache Settings, allowing you to override
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>comment</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}An optional comment about the Director.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>conditions</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1condition">List[Servicev1Condition]</a></span>
    </dt>
    <dd>{{% md %}}A set of conditions to add logic to any basic
configuration object in this service. Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>default_<wbr>host</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}Sets the host header.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>default_<wbr>ttl</span>
        <span class="property-indicator"></span>
        <span class="property-type">float</span>
    </dt>
    <dd>{{% md %}}The default Time-to-live (TTL) for
requests.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>dictionaries</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1dictionary">List[Servicev1Dictionary]</a></span>
    </dt>
    <dd>{{% md %}}A set of dictionaries that allow the storing of key values pair for use within VCL functions. Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>directors</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1director">List[Servicev1Director]</a></span>
    </dt>
    <dd>{{% md %}}A director to allow more control over balancing traffic over backends.
when an item is not to be cached based on an above `condition`. Defined below
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>domains</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1domain">List[Servicev1Domain]</a></span>
    </dt>
    <dd>{{% md %}}If you created the S3 bucket outside of `us-east-1`,
then specify the corresponding bucket endpoint. Example: `s3-us-west-2.amazonaws.com`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>dynamicsnippets</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1dynamicsnippet">List[Servicev1Dynamicsnippet]</a></span>
    </dt>
    <dd>{{% md %}}A set of custom, "dynamic" VCL Snippet configuration blocks.  Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>force_<wbr>destroy</span>
        <span class="property-indicator"></span>
        <span class="property-type">bool</span>
    </dt>
    <dd>{{% md %}}Services that are active cannot be destroyed. In
order to destroy the Service, set `force_destroy` to `true`. Default `false`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>gcsloggings</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1gcslogging">List[Servicev1Gcslogging]</a></span>
    </dt>
    <dd>{{% md %}}A gcs endpoint to send streaming logs too.
Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>gzips</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1gzip">List[Servicev1Gzip]</a></span>
    </dt>
    <dd>{{% md %}}A set of gzip rules to control automatic gzipping of
content. Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>headers</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1header">List[Servicev1Header]</a></span>
    </dt>
    <dd>{{% md %}}A set of Headers to manipulate for each request. Defined
below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>healthchecks</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1healthcheck">List[Servicev1Healthcheck]</a></span>
    </dt>
    <dd>{{% md %}}Name of a defined `healthcheck` to assign to this backend.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>logentries</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1logentry">List[Servicev1Logentry]</a></span>
    </dt>
    <dd>{{% md %}}A logentries endpoint to send streaming logs too.
Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>name</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}A unique name to identify this dictionary.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>papertrails</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1papertrail">List[Servicev1Papertrail]</a></span>
    </dt>
    <dd>{{% md %}}A Papertrail endpoint to send streaming logs too.
Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>request_<wbr>settings</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1requestsetting">List[Servicev1Request<wbr>Setting]</a></span>
    </dt>
    <dd>{{% md %}}A set of Request modifiers. Defined below
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>response_<wbr>objects</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1responseobject">List[Servicev1Response<wbr>Object]</a></span>
    </dt>
    <dd>{{% md %}}Allows you to create synthetic responses that exist entirely on the varnish machine. Useful for creating error or maintenance pages that exists outside the scope of your datacenter. Best when used with Condition objects.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>s3loggings</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1s3logging">List[Servicev1S3logging]</a></span>
    </dt>
    <dd>{{% md %}}A set of S3 Buckets to send streaming logs too.
Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>snippets</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1snippet">List[Servicev1Snippet]</a></span>
    </dt>
    <dd>{{% md %}}A set of custom, "regular" (non-dynamic) VCL Snippet configuration blocks.  Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>splunks</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1splunk">List[Servicev1Splunk]</a></span>
    </dt>
    <dd>{{% md %}}A Splunk endpoint to send streaming logs too.
Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>sumologics</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1sumologic">List[Servicev1Sumologic]</a></span>
    </dt>
    <dd>{{% md %}}A Sumologic endpoint to send streaming logs too.
Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>syslogs</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1syslog">List[Servicev1Syslog]</a></span>
    </dt>
    <dd>{{% md %}}A syslog endpoint to send streaming logs too.
Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>vcls</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1vcl">List[Servicev1Vcl]</a></span>
    </dt>
    <dd>{{% md %}}A set of custom VCL configuration blocks. The
ability to upload custom VCL code is not enabled by default for new Fastly
accounts (see the [Fastly documentation](https://docs.fastly.com/guides/vcl/uploading-custom-vcl) for details).
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>version_<wbr>comment</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}Description field for the version.
{{% /md %}}</dd>

</dl>
{{% /choosable %}}







## Servicev1 Output Properties

The following output properties are available:




{{% choosable language csharp %}}
<dl class="resources-properties">

    <dt class="property-"
            title="">
        <span>Acls</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1acl">List&lt;Servicev1Acl&gt;?</a></span>
    </dt>
    <dd>{{% md %}}A set of ACL configuration blocks.  Defined below.
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>Activate</span>
        <span class="property-indicator"></span>
        <span class="property-type">bool?</span>
    </dt>
    <dd>{{% md %}}Conditionally prevents the Service from being activated. The apply step will continue to create a new draft version but will not activate it if this is set to false. Default true.
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>Active<wbr>Version</span>
        <span class="property-indicator"></span>
        <span class="property-type">int</span>
    </dt>
    <dd>{{% md %}}The currently active version of your Fastly Service.
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>Backends</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1backend">List&lt;Servicev1Backend&gt;?</a></span>
    </dt>
    <dd>{{% md %}}A set of Backends to service requests from your Domains.
Defined below. Backends must be defined in this argument, or defined in the
`vcl` argument below
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>Bigqueryloggings</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1bigquerylogging">List&lt;Servicev1Bigquerylogging&gt;?</a></span>
    </dt>
    <dd>{{% md %}}A BigQuery endpoint to send streaming logs too.
Defined below.
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>Blobstorageloggings</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1blobstoragelogging">List&lt;Servicev1Blobstoragelogging&gt;?</a></span>
    </dt>
    <dd>{{% md %}}An Azure Blob Storage endpoint to send streaming logs too.
Defined below.
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>Cache<wbr>Settings</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1cachesetting">List&lt;Servicev1Cache<wbr>Setting&gt;?</a></span>
    </dt>
    <dd>{{% md %}}A set of Cache Settings, allowing you to override
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>Cloned<wbr>Version</span>
        <span class="property-indicator"></span>
        <span class="property-type">int</span>
    </dt>
    <dd>{{% md %}}{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>Comment</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}An optional comment about the Director.
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>Conditions</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1condition">List&lt;Servicev1Condition&gt;?</a></span>
    </dt>
    <dd>{{% md %}}A set of conditions to add logic to any basic
configuration object in this service. Defined below.
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>Default<wbr>Host</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}Sets the host header.
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>Default<wbr>Ttl</span>
        <span class="property-indicator"></span>
        <span class="property-type">int?</span>
    </dt>
    <dd>{{% md %}}The default Time-to-live (TTL) for
requests.
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>Dictionaries</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1dictionary">List&lt;Servicev1Dictionary&gt;?</a></span>
    </dt>
    <dd>{{% md %}}A set of dictionaries that allow the storing of key values pair for use within VCL functions. Defined below.
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>Directors</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1director">List&lt;Servicev1Director&gt;?</a></span>
    </dt>
    <dd>{{% md %}}A director to allow more control over balancing traffic over backends.
when an item is not to be cached based on an above `condition`. Defined below
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>Domains</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1domain">List&lt;Servicev1Domain&gt;</a></span>
    </dt>
    <dd>{{% md %}}If you created the S3 bucket outside of `us-east-1`,
then specify the corresponding bucket endpoint. Example: `s3-us-west-2.amazonaws.com`.
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>Dynamicsnippets</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1dynamicsnippet">List&lt;Servicev1Dynamicsnippet&gt;?</a></span>
    </dt>
    <dd>{{% md %}}A set of custom, "dynamic" VCL Snippet configuration blocks.  Defined below.
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>Force<wbr>Destroy</span>
        <span class="property-indicator"></span>
        <span class="property-type">bool?</span>
    </dt>
    <dd>{{% md %}}Services that are active cannot be destroyed. In
order to destroy the Service, set `force_destroy` to `true`. Default `false`.
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>Gcsloggings</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1gcslogging">List&lt;Servicev1Gcslogging&gt;?</a></span>
    </dt>
    <dd>{{% md %}}A gcs endpoint to send streaming logs too.
Defined below.
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>Gzips</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1gzip">List&lt;Servicev1Gzip&gt;?</a></span>
    </dt>
    <dd>{{% md %}}A set of gzip rules to control automatic gzipping of
content. Defined below.
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>Headers</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1header">List&lt;Servicev1Header&gt;?</a></span>
    </dt>
    <dd>{{% md %}}A set of Headers to manipulate for each request. Defined
below.
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>Healthchecks</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1healthcheck">List&lt;Servicev1Healthcheck&gt;?</a></span>
    </dt>
    <dd>{{% md %}}Name of a defined `healthcheck` to assign to this backend.
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>Logentries</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1logentry">List&lt;Servicev1Logentry&gt;?</a></span>
    </dt>
    <dd>{{% md %}}A logentries endpoint to send streaming logs too.
Defined below.
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>Name</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}A unique name to identify this dictionary.
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>Papertrails</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1papertrail">List&lt;Servicev1Papertrail&gt;?</a></span>
    </dt>
    <dd>{{% md %}}A Papertrail endpoint to send streaming logs too.
Defined below.
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>Request<wbr>Settings</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1requestsetting">List&lt;Servicev1Request<wbr>Setting&gt;?</a></span>
    </dt>
    <dd>{{% md %}}A set of Request modifiers. Defined below
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>Response<wbr>Objects</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1responseobject">List&lt;Servicev1Response<wbr>Object&gt;?</a></span>
    </dt>
    <dd>{{% md %}}Allows you to create synthetic responses that exist entirely on the varnish machine. Useful for creating error or maintenance pages that exists outside the scope of your datacenter. Best when used with Condition objects.
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>S3loggings</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1s3logging">List&lt;Servicev1S3logging&gt;?</a></span>
    </dt>
    <dd>{{% md %}}A set of S3 Buckets to send streaming logs too.
Defined below.
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>Snippets</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1snippet">List&lt;Servicev1Snippet&gt;?</a></span>
    </dt>
    <dd>{{% md %}}A set of custom, "regular" (non-dynamic) VCL Snippet configuration blocks.  Defined below.
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>Splunks</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1splunk">List&lt;Servicev1Splunk&gt;?</a></span>
    </dt>
    <dd>{{% md %}}A Splunk endpoint to send streaming logs too.
Defined below.
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>Sumologics</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1sumologic">List&lt;Servicev1Sumologic&gt;?</a></span>
    </dt>
    <dd>{{% md %}}A Sumologic endpoint to send streaming logs too.
Defined below.
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>Syslogs</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1syslog">List&lt;Servicev1Syslog&gt;?</a></span>
    </dt>
    <dd>{{% md %}}A syslog endpoint to send streaming logs too.
Defined below.
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>Vcls</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1vcl">List&lt;Servicev1Vcl&gt;?</a></span>
    </dt>
    <dd>{{% md %}}A set of custom VCL configuration blocks. The
ability to upload custom VCL code is not enabled by default for new Fastly
accounts (see the [Fastly documentation](https://docs.fastly.com/guides/vcl/uploading-custom-vcl) for details).
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>Version<wbr>Comment</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}Description field for the version.
{{% /md %}}</dd>

</dl>
{{% /choosable %}}


{{% choosable language go %}}
<dl class="resources-properties">

    <dt class="property-"
            title="">
        <span>Acls</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1acl">[]Servicev1Acl</a></span>
    </dt>
    <dd>{{% md %}}A set of ACL configuration blocks.  Defined below.
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>Activate</span>
        <span class="property-indicator"></span>
        <span class="property-type">*bool</span>
    </dt>
    <dd>{{% md %}}Conditionally prevents the Service from being activated. The apply step will continue to create a new draft version but will not activate it if this is set to false. Default true.
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>Active<wbr>Version</span>
        <span class="property-indicator"></span>
        <span class="property-type">int</span>
    </dt>
    <dd>{{% md %}}The currently active version of your Fastly Service.
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>Backends</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1backend">[]Servicev1Backend</a></span>
    </dt>
    <dd>{{% md %}}A set of Backends to service requests from your Domains.
Defined below. Backends must be defined in this argument, or defined in the
`vcl` argument below
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>Bigqueryloggings</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1bigquerylogging">[]Servicev1Bigquerylogging</a></span>
    </dt>
    <dd>{{% md %}}A BigQuery endpoint to send streaming logs too.
Defined below.
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>Blobstorageloggings</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1blobstoragelogging">[]Servicev1Blobstoragelogging</a></span>
    </dt>
    <dd>{{% md %}}An Azure Blob Storage endpoint to send streaming logs too.
Defined below.
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>Cache<wbr>Settings</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1cachesetting">[]Servicev1Cache<wbr>Setting</a></span>
    </dt>
    <dd>{{% md %}}A set of Cache Settings, allowing you to override
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>Cloned<wbr>Version</span>
        <span class="property-indicator"></span>
        <span class="property-type">int</span>
    </dt>
    <dd>{{% md %}}{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>Comment</span>
        <span class="property-indicator"></span>
        <span class="property-type">*string</span>
    </dt>
    <dd>{{% md %}}An optional comment about the Director.
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>Conditions</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1condition">[]Servicev1Condition</a></span>
    </dt>
    <dd>{{% md %}}A set of conditions to add logic to any basic
configuration object in this service. Defined below.
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>Default<wbr>Host</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}Sets the host header.
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>Default<wbr>Ttl</span>
        <span class="property-indicator"></span>
        <span class="property-type">*int</span>
    </dt>
    <dd>{{% md %}}The default Time-to-live (TTL) for
requests.
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>Dictionaries</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1dictionary">[]Servicev1Dictionary</a></span>
    </dt>
    <dd>{{% md %}}A set of dictionaries that allow the storing of key values pair for use within VCL functions. Defined below.
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>Directors</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1director">[]Servicev1Director</a></span>
    </dt>
    <dd>{{% md %}}A director to allow more control over balancing traffic over backends.
when an item is not to be cached based on an above `condition`. Defined below
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>Domains</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1domain">[]Servicev1Domain</a></span>
    </dt>
    <dd>{{% md %}}If you created the S3 bucket outside of `us-east-1`,
then specify the corresponding bucket endpoint. Example: `s3-us-west-2.amazonaws.com`.
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>Dynamicsnippets</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1dynamicsnippet">[]Servicev1Dynamicsnippet</a></span>
    </dt>
    <dd>{{% md %}}A set of custom, "dynamic" VCL Snippet configuration blocks.  Defined below.
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>Force<wbr>Destroy</span>
        <span class="property-indicator"></span>
        <span class="property-type">*bool</span>
    </dt>
    <dd>{{% md %}}Services that are active cannot be destroyed. In
order to destroy the Service, set `force_destroy` to `true`. Default `false`.
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>Gcsloggings</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1gcslogging">[]Servicev1Gcslogging</a></span>
    </dt>
    <dd>{{% md %}}A gcs endpoint to send streaming logs too.
Defined below.
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>Gzips</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1gzip">[]Servicev1Gzip</a></span>
    </dt>
    <dd>{{% md %}}A set of gzip rules to control automatic gzipping of
content. Defined below.
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>Headers</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1header">[]Servicev1Header</a></span>
    </dt>
    <dd>{{% md %}}A set of Headers to manipulate for each request. Defined
below.
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>Healthchecks</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1healthcheck">[]Servicev1Healthcheck</a></span>
    </dt>
    <dd>{{% md %}}Name of a defined `healthcheck` to assign to this backend.
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>Logentries</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1logentry">[]Servicev1Logentry</a></span>
    </dt>
    <dd>{{% md %}}A logentries endpoint to send streaming logs too.
Defined below.
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>Name</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}A unique name to identify this dictionary.
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>Papertrails</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1papertrail">[]Servicev1Papertrail</a></span>
    </dt>
    <dd>{{% md %}}A Papertrail endpoint to send streaming logs too.
Defined below.
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>Request<wbr>Settings</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1requestsetting">[]Servicev1Request<wbr>Setting</a></span>
    </dt>
    <dd>{{% md %}}A set of Request modifiers. Defined below
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>Response<wbr>Objects</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1responseobject">[]Servicev1Response<wbr>Object</a></span>
    </dt>
    <dd>{{% md %}}Allows you to create synthetic responses that exist entirely on the varnish machine. Useful for creating error or maintenance pages that exists outside the scope of your datacenter. Best when used with Condition objects.
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>S3loggings</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1s3logging">[]Servicev1S3logging</a></span>
    </dt>
    <dd>{{% md %}}A set of S3 Buckets to send streaming logs too.
Defined below.
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>Snippets</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1snippet">[]Servicev1Snippet</a></span>
    </dt>
    <dd>{{% md %}}A set of custom, "regular" (non-dynamic) VCL Snippet configuration blocks.  Defined below.
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>Splunks</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1splunk">[]Servicev1Splunk</a></span>
    </dt>
    <dd>{{% md %}}A Splunk endpoint to send streaming logs too.
Defined below.
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>Sumologics</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1sumologic">[]Servicev1Sumologic</a></span>
    </dt>
    <dd>{{% md %}}A Sumologic endpoint to send streaming logs too.
Defined below.
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>Syslogs</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1syslog">[]Servicev1Syslog</a></span>
    </dt>
    <dd>{{% md %}}A syslog endpoint to send streaming logs too.
Defined below.
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>Vcls</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1vcl">[]Servicev1Vcl</a></span>
    </dt>
    <dd>{{% md %}}A set of custom VCL configuration blocks. The
ability to upload custom VCL code is not enabled by default for new Fastly
accounts (see the [Fastly documentation](https://docs.fastly.com/guides/vcl/uploading-custom-vcl) for details).
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>Version<wbr>Comment</span>
        <span class="property-indicator"></span>
        <span class="property-type">*string</span>
    </dt>
    <dd>{{% md %}}Description field for the version.
{{% /md %}}</dd>

</dl>
{{% /choosable %}}


{{% choosable language nodejs %}}
<dl class="resources-properties">

    <dt class="property-"
            title="">
        <span>acls</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1acl">Servicev1Acl[]?</a></span>
    </dt>
    <dd>{{% md %}}A set of ACL configuration blocks.  Defined below.
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>activate</span>
        <span class="property-indicator"></span>
        <span class="property-type">boolean?</span>
    </dt>
    <dd>{{% md %}}Conditionally prevents the Service from being activated. The apply step will continue to create a new draft version but will not activate it if this is set to false. Default true.
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>active<wbr>Version</span>
        <span class="property-indicator"></span>
        <span class="property-type">number</span>
    </dt>
    <dd>{{% md %}}The currently active version of your Fastly Service.
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>backends</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1backend">Servicev1Backend[]?</a></span>
    </dt>
    <dd>{{% md %}}A set of Backends to service requests from your Domains.
Defined below. Backends must be defined in this argument, or defined in the
`vcl` argument below
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>bigqueryloggings</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1bigquerylogging">Servicev1Bigquerylogging[]?</a></span>
    </dt>
    <dd>{{% md %}}A BigQuery endpoint to send streaming logs too.
Defined below.
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>blobstorageloggings</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1blobstoragelogging">Servicev1Blobstoragelogging[]?</a></span>
    </dt>
    <dd>{{% md %}}An Azure Blob Storage endpoint to send streaming logs too.
Defined below.
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>cache<wbr>Settings</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1cachesetting">Servicev1Cache<wbr>Setting[]?</a></span>
    </dt>
    <dd>{{% md %}}A set of Cache Settings, allowing you to override
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>cloned<wbr>Version</span>
        <span class="property-indicator"></span>
        <span class="property-type">number</span>
    </dt>
    <dd>{{% md %}}{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>comment</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}An optional comment about the Director.
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>conditions</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1condition">Servicev1Condition[]?</a></span>
    </dt>
    <dd>{{% md %}}A set of conditions to add logic to any basic
configuration object in this service. Defined below.
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>default<wbr>Host</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}Sets the host header.
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>default<wbr>Ttl</span>
        <span class="property-indicator"></span>
        <span class="property-type">number?</span>
    </dt>
    <dd>{{% md %}}The default Time-to-live (TTL) for
requests.
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>dictionaries</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1dictionary">Servicev1Dictionary[]?</a></span>
    </dt>
    <dd>{{% md %}}A set of dictionaries that allow the storing of key values pair for use within VCL functions. Defined below.
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>directors</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1director">Servicev1Director[]?</a></span>
    </dt>
    <dd>{{% md %}}A director to allow more control over balancing traffic over backends.
when an item is not to be cached based on an above `condition`. Defined below
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>domains</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1domain">Servicev1Domain[]</a></span>
    </dt>
    <dd>{{% md %}}If you created the S3 bucket outside of `us-east-1`,
then specify the corresponding bucket endpoint. Example: `s3-us-west-2.amazonaws.com`.
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>dynamicsnippets</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1dynamicsnippet">Servicev1Dynamicsnippet[]?</a></span>
    </dt>
    <dd>{{% md %}}A set of custom, "dynamic" VCL Snippet configuration blocks.  Defined below.
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>force<wbr>Destroy</span>
        <span class="property-indicator"></span>
        <span class="property-type">boolean?</span>
    </dt>
    <dd>{{% md %}}Services that are active cannot be destroyed. In
order to destroy the Service, set `force_destroy` to `true`. Default `false`.
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>gcsloggings</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1gcslogging">Servicev1Gcslogging[]?</a></span>
    </dt>
    <dd>{{% md %}}A gcs endpoint to send streaming logs too.
Defined below.
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>gzips</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1gzip">Servicev1Gzip[]?</a></span>
    </dt>
    <dd>{{% md %}}A set of gzip rules to control automatic gzipping of
content. Defined below.
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>headers</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1header">Servicev1Header[]?</a></span>
    </dt>
    <dd>{{% md %}}A set of Headers to manipulate for each request. Defined
below.
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>healthchecks</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1healthcheck">Servicev1Healthcheck[]?</a></span>
    </dt>
    <dd>{{% md %}}Name of a defined `healthcheck` to assign to this backend.
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>logentries</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1logentry">Servicev1Logentry[]?</a></span>
    </dt>
    <dd>{{% md %}}A logentries endpoint to send streaming logs too.
Defined below.
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>name</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}A unique name to identify this dictionary.
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>papertrails</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1papertrail">Servicev1Papertrail[]?</a></span>
    </dt>
    <dd>{{% md %}}A Papertrail endpoint to send streaming logs too.
Defined below.
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>request<wbr>Settings</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1requestsetting">Servicev1Request<wbr>Setting[]?</a></span>
    </dt>
    <dd>{{% md %}}A set of Request modifiers. Defined below
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>response<wbr>Objects</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1responseobject">Servicev1Response<wbr>Object[]?</a></span>
    </dt>
    <dd>{{% md %}}Allows you to create synthetic responses that exist entirely on the varnish machine. Useful for creating error or maintenance pages that exists outside the scope of your datacenter. Best when used with Condition objects.
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>s3loggings</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1s3logging">Servicev1S3logging[]?</a></span>
    </dt>
    <dd>{{% md %}}A set of S3 Buckets to send streaming logs too.
Defined below.
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>snippets</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1snippet">Servicev1Snippet[]?</a></span>
    </dt>
    <dd>{{% md %}}A set of custom, "regular" (non-dynamic) VCL Snippet configuration blocks.  Defined below.
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>splunks</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1splunk">Servicev1Splunk[]?</a></span>
    </dt>
    <dd>{{% md %}}A Splunk endpoint to send streaming logs too.
Defined below.
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>sumologics</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1sumologic">Servicev1Sumologic[]?</a></span>
    </dt>
    <dd>{{% md %}}A Sumologic endpoint to send streaming logs too.
Defined below.
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>syslogs</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1syslog">Servicev1Syslog[]?</a></span>
    </dt>
    <dd>{{% md %}}A syslog endpoint to send streaming logs too.
Defined below.
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>vcls</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1vcl">Servicev1Vcl[]?</a></span>
    </dt>
    <dd>{{% md %}}A set of custom VCL configuration blocks. The
ability to upload custom VCL code is not enabled by default for new Fastly
accounts (see the [Fastly documentation](https://docs.fastly.com/guides/vcl/uploading-custom-vcl) for details).
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>version<wbr>Comment</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}Description field for the version.
{{% /md %}}</dd>

</dl>
{{% /choosable %}}


{{% choosable language python %}}
<dl class="resources-properties">

    <dt class="property-"
            title="">
        <span>acls</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1acl">List[Servicev1Acl]</a></span>
    </dt>
    <dd>{{% md %}}A set of ACL configuration blocks.  Defined below.
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>activate</span>
        <span class="property-indicator"></span>
        <span class="property-type">bool</span>
    </dt>
    <dd>{{% md %}}Conditionally prevents the Service from being activated. The apply step will continue to create a new draft version but will not activate it if this is set to false. Default true.
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>active_<wbr>version</span>
        <span class="property-indicator"></span>
        <span class="property-type">float</span>
    </dt>
    <dd>{{% md %}}The currently active version of your Fastly Service.
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>backends</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1backend">List[Servicev1Backend]</a></span>
    </dt>
    <dd>{{% md %}}A set of Backends to service requests from your Domains.
Defined below. Backends must be defined in this argument, or defined in the
`vcl` argument below
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>bigqueryloggings</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1bigquerylogging">List[Servicev1Bigquerylogging]</a></span>
    </dt>
    <dd>{{% md %}}A BigQuery endpoint to send streaming logs too.
Defined below.
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>blobstorageloggings</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1blobstoragelogging">List[Servicev1Blobstoragelogging]</a></span>
    </dt>
    <dd>{{% md %}}An Azure Blob Storage endpoint to send streaming logs too.
Defined below.
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>cache_<wbr>settings</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1cachesetting">List[Servicev1Cache<wbr>Setting]</a></span>
    </dt>
    <dd>{{% md %}}A set of Cache Settings, allowing you to override
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>cloned_<wbr>version</span>
        <span class="property-indicator"></span>
        <span class="property-type">float</span>
    </dt>
    <dd>{{% md %}}{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>comment</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}An optional comment about the Director.
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>conditions</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1condition">List[Servicev1Condition]</a></span>
    </dt>
    <dd>{{% md %}}A set of conditions to add logic to any basic
configuration object in this service. Defined below.
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>default_<wbr>host</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}Sets the host header.
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>default_<wbr>ttl</span>
        <span class="property-indicator"></span>
        <span class="property-type">float</span>
    </dt>
    <dd>{{% md %}}The default Time-to-live (TTL) for
requests.
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>dictionaries</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1dictionary">List[Servicev1Dictionary]</a></span>
    </dt>
    <dd>{{% md %}}A set of dictionaries that allow the storing of key values pair for use within VCL functions. Defined below.
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>directors</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1director">List[Servicev1Director]</a></span>
    </dt>
    <dd>{{% md %}}A director to allow more control over balancing traffic over backends.
when an item is not to be cached based on an above `condition`. Defined below
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>domains</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1domain">List[Servicev1Domain]</a></span>
    </dt>
    <dd>{{% md %}}If you created the S3 bucket outside of `us-east-1`,
then specify the corresponding bucket endpoint. Example: `s3-us-west-2.amazonaws.com`.
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>dynamicsnippets</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1dynamicsnippet">List[Servicev1Dynamicsnippet]</a></span>
    </dt>
    <dd>{{% md %}}A set of custom, "dynamic" VCL Snippet configuration blocks.  Defined below.
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>force_<wbr>destroy</span>
        <span class="property-indicator"></span>
        <span class="property-type">bool</span>
    </dt>
    <dd>{{% md %}}Services that are active cannot be destroyed. In
order to destroy the Service, set `force_destroy` to `true`. Default `false`.
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>gcsloggings</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1gcslogging">List[Servicev1Gcslogging]</a></span>
    </dt>
    <dd>{{% md %}}A gcs endpoint to send streaming logs too.
Defined below.
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>gzips</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1gzip">List[Servicev1Gzip]</a></span>
    </dt>
    <dd>{{% md %}}A set of gzip rules to control automatic gzipping of
content. Defined below.
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>headers</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1header">List[Servicev1Header]</a></span>
    </dt>
    <dd>{{% md %}}A set of Headers to manipulate for each request. Defined
below.
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>healthchecks</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1healthcheck">List[Servicev1Healthcheck]</a></span>
    </dt>
    <dd>{{% md %}}Name of a defined `healthcheck` to assign to this backend.
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>logentries</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1logentry">List[Servicev1Logentry]</a></span>
    </dt>
    <dd>{{% md %}}A logentries endpoint to send streaming logs too.
Defined below.
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>name</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}A unique name to identify this dictionary.
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>papertrails</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1papertrail">List[Servicev1Papertrail]</a></span>
    </dt>
    <dd>{{% md %}}A Papertrail endpoint to send streaming logs too.
Defined below.
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>request_<wbr>settings</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1requestsetting">List[Servicev1Request<wbr>Setting]</a></span>
    </dt>
    <dd>{{% md %}}A set of Request modifiers. Defined below
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>response_<wbr>objects</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1responseobject">List[Servicev1Response<wbr>Object]</a></span>
    </dt>
    <dd>{{% md %}}Allows you to create synthetic responses that exist entirely on the varnish machine. Useful for creating error or maintenance pages that exists outside the scope of your datacenter. Best when used with Condition objects.
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>s3loggings</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1s3logging">List[Servicev1S3logging]</a></span>
    </dt>
    <dd>{{% md %}}A set of S3 Buckets to send streaming logs too.
Defined below.
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>snippets</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1snippet">List[Servicev1Snippet]</a></span>
    </dt>
    <dd>{{% md %}}A set of custom, "regular" (non-dynamic) VCL Snippet configuration blocks.  Defined below.
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>splunks</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1splunk">List[Servicev1Splunk]</a></span>
    </dt>
    <dd>{{% md %}}A Splunk endpoint to send streaming logs too.
Defined below.
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>sumologics</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1sumologic">List[Servicev1Sumologic]</a></span>
    </dt>
    <dd>{{% md %}}A Sumologic endpoint to send streaming logs too.
Defined below.
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>syslogs</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1syslog">List[Servicev1Syslog]</a></span>
    </dt>
    <dd>{{% md %}}A syslog endpoint to send streaming logs too.
Defined below.
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>vcls</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1vcl">List[Servicev1Vcl]</a></span>
    </dt>
    <dd>{{% md %}}A set of custom VCL configuration blocks. The
ability to upload custom VCL code is not enabled by default for new Fastly
accounts (see the [Fastly documentation](https://docs.fastly.com/guides/vcl/uploading-custom-vcl) for details).
{{% /md %}}</dd>

    <dt class="property-"
            title="">
        <span>version_<wbr>comment</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}Description field for the version.
{{% /md %}}</dd>

</dl>
{{% /choosable %}}








## Look up an Existing Servicev1 Resource

Get an existing Servicev1 resource's state with the given name, ID, and optional extra properties used to qualify the lookup.

{{< chooser language "javascript,typescript,python,go,csharp  " / >}}

{{% choosable language nodejs %}}
<div class="highlight"><pre class="chroma"><code class="language-typescript" data-lang="typescript"><span class="k">public static </span><span class="nf">get</span><span class="p">(</span><span class="nx">name</span>: <span class="nx"><a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/string">string</a></span><span class="p">, </span><span class="nx">id</span>: <span class="nx"><a href="/docs/reference/pkg/nodejs/pulumi/pulumi/#ID">Input&lt;ID&gt;</a></span><span class="p">, </span><span class="nx">state</span>?: <span class="nx"><a href="/docs/reference/pkg/nodejs/pulumi/fastly/#Servicev1State">Servicev1State</a></span><span class="p">, </span><span class="nx">opts</span>?: <span class="nx"><a href="/docs/reference/pkg/nodejs/pulumi/pulumi/#CustomResourceOptions">CustomResourceOptions</a></span><span class="p">): </span><span class="nx"><a href="/docs/reference/pkg/nodejs/pulumi/fastly/#Servicev1">Servicev1</a></span></code></pre></div>
{{% /choosable %}}

{{% choosable language python %}}
<div class="highlight"><pre class="chroma"><code class="language-python" data-lang="python"><span class="k">static </span><span class="nf">get</span><span class="p">(resource_name, id, opts=None, </span>acls=None<span class="p">, </span>activate=None<span class="p">, </span>active_version=None<span class="p">, </span>backends=None<span class="p">, </span>bigqueryloggings=None<span class="p">, </span>blobstorageloggings=None<span class="p">, </span>cache_settings=None<span class="p">, </span>cloned_version=None<span class="p">, </span>comment=None<span class="p">, </span>conditions=None<span class="p">, </span>default_host=None<span class="p">, </span>default_ttl=None<span class="p">, </span>dictionaries=None<span class="p">, </span>directors=None<span class="p">, </span>domains=None<span class="p">, </span>dynamicsnippets=None<span class="p">, </span>force_destroy=None<span class="p">, </span>gcsloggings=None<span class="p">, </span>gzips=None<span class="p">, </span>headers=None<span class="p">, </span>healthchecks=None<span class="p">, </span>logentries=None<span class="p">, </span>name=None<span class="p">, </span>papertrails=None<span class="p">, </span>request_settings=None<span class="p">, </span>response_objects=None<span class="p">, </span>s3loggings=None<span class="p">, </span>snippets=None<span class="p">, </span>splunks=None<span class="p">, </span>sumologics=None<span class="p">, </span>syslogs=None<span class="p">, </span>vcls=None<span class="p">, </span>version_comment=None<span class="p">, __props__=None);</span></code></pre></div>
{{% /choosable %}}

{{% choosable language go %}}
<div class="highlight"><pre class="chroma"><code class="language-go" data-lang="go"><span class="k">func </span>GetServicev1<span class="p">(</span><span class="nx">ctx</span> *<span class="nx"><a href="https://pkg.go.dev/github.com/pulumi/pulumi/sdk/go/pulumi?tab=doc#Context">Context</a></span><span class="p">, </span><span class="nx">name</span> <span class="nx"><a href="https://golang.org/pkg/builtin/#string">string</a></span><span class="p">, </span><span class="nx">id</span> <span class="nx"><a href="https://pkg.go.dev/github.com/pulumi/pulumi/sdk/go/pulumi?tab=doc#IDInput">IDInput</a></span><span class="p">, </span><span class="nx">state</span> *<span class="nx"><a href="https://pkg.go.dev/github.com/pulumi/pulumi-fastly/sdk/go/fastly/?tab=doc#Servicev1State">Servicev1State</a></span><span class="p">, </span><span class="nx">opts</span> ...<span class="nx"><a href="https://pkg.go.dev/github.com/pulumi/pulumi/sdk/go/pulumi?tab=doc#ResourceOption">ResourceOption</a></span><span class="p">) (*<span class="nx"><a href="https://pkg.go.dev/github.com/pulumi/pulumi-fastly/sdk/go/fastly/?tab=doc#Servicev1">Servicev1</a></span>, error)</span></code></pre></div>
{{% /choosable %}}

{{% choosable language csharp %}}
<div class="highlight"><pre class="chroma"><code class="language-csharp" data-lang="csharp"><span class="k">public static </span><span class="nx"><a href="/docs/reference/pkg/dotnet/Pulumi.Fastly/Pulumi.Fastly..Servicev1.html">Servicev1</a></span><span class="nf"> Get</span><span class="p">(</span><span class="nx"><a href="https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/builtin-types/built-in-types">string</a></span> <span class="nx">name<span class="p">, </span><span class="nx"><a href="/docs/reference/pkg/dotnet/Pulumi/Pulumi.Input.html">Input&lt;string&gt;</a></span> <span class="nx">id<span class="p">, </span><span class="nx"><a href="/docs/reference/pkg/dotnet/Pulumi.Fastly/Pulumi.Fastly..Servicev1State.html">Servicev1State</a></span>? <span class="nx">state<span class="p">, </span><span class="nx"><a href="/docs/reference/pkg/dotnet/Pulumi/Pulumi.CustomResourceOptions.html">CustomResourceOptions</a></span>? <span class="nx">opts = null<span class="p">)</span></code></pre></div>
{{% /choosable %}}

{{% choosable language nodejs %}}

<dl class="resources-properties">
    <dt class="property-required" title="Required">
        <span>name</span>
        <span class="property-indicator"></span>
    </dt>
    <dd>The unique name of the resulting resource.</dd>
    <dt class="property-required" title="Required">
        <span>id</span>
        <span class="property-indicator"></span>
    </dt>
    <dd>The <em>unique</em> provider ID of the resource to lookup.</dd>
    <dt class="property-optional" title="Optional">
        <span>state</span>
        <span class="property-indicator"></span>
    </dt>
    <dd>Any extra arguments used during the lookup.</dd>
    <dt class="property-optional" title="Optional">
        <span>opts</span>
        <span class="property-indicator"></span>
    </dt>
    <dd>A bag of options that control this resource's behavior.</dd>
</dl>

{{% /choosable %}}

{{% choosable language python %}}
<dl class="resources-properties">
    <dt class="property-required" title="Required">
        <span>resource_name</span>
        <span class="property-indicator"></span>
    </dt>
    <dd>The unique name of the resulting resource.</dd>
    <dt class="property-required" title="Optional">
        <span>id</span>
        <span class="property-indicator"></span>
    </dt>
    <dd>The <em>unique</em> provider ID of the resource to lookup.</dd>
</dl>
{{% /choosable %}}

{{% choosable language go %}}

<dl class="resources-properties">
    <dt class="property-required" title="Required">
        <span>name</span>
        <span class="property-indicator"></span>
    </dt>
    <dd>The unique name of the resulting resource.</dd>
    <dt class="property-required" title="Required">
        <span>id</span>
        <span class="property-indicator"></span>
    </dt>
    <dd>The <em>unique</em> provider ID of the resource to lookup.</dd>
    <dt class="property-optional" title="Optional">
        <span>state</span>
        <span class="property-indicator"></span>
    </dt>
    <dd>Any extra arguments used during the lookup.</dd>
    <dt class="property-optional" title="Optional">
        <span>opts</span>
        <span class="property-indicator"></span>
    </dt>
    <dd>A bag of options that control this resource's behavior.</dd>
</dl>

{{% /choosable %}}

{{% choosable language csharp %}}

<dl class="resources-properties">
    <dt class="property-required" title="Required">
        <span>name</span>
        <span class="property-indicator"></span>
    </dt>
    <dd>The unique name of the resulting resource.</dd>
    <dt class="property-required" title="Required">
        <span>id</span>
        <span class="property-indicator"></span>
    </dt>
    <dd>The <em>unique</em> provider ID of the resource to lookup.</dd>
    <dt class="property-optional" title="Optional">
        <span>state</span>
        <span class="property-indicator"></span>
    </dt>
    <dd>Any extra arguments used during the lookup.</dd>
    <dt class="property-optional" title="Optional">
        <span>opts</span>
        <span class="property-indicator"></span>
    </dt>
    <dd>A bag of options that control this resource's behavior.</dd>
</dl>

{{% /choosable %}}

The following state arguments are supported:



{{% choosable language csharp %}}
<dl class="resources-properties">

    <dt class="property-optional"
            title="Optional">
        <span>Acls</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1acl">List&lt;Servicev1Acl<wbr>Args&gt;?</a></span>
    </dt>
    <dd>{{% md %}}A set of ACL configuration blocks.  Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Activate</span>
        <span class="property-indicator"></span>
        <span class="property-type">bool?</span>
    </dt>
    <dd>{{% md %}}Conditionally prevents the Service from being activated. The apply step will continue to create a new draft version but will not activate it if this is set to false. Default true.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Active<wbr>Version</span>
        <span class="property-indicator"></span>
        <span class="property-type">int?</span>
    </dt>
    <dd>{{% md %}}The currently active version of your Fastly Service.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Backends</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1backend">List&lt;Servicev1Backend<wbr>Args&gt;?</a></span>
    </dt>
    <dd>{{% md %}}A set of Backends to service requests from your Domains.
Defined below. Backends must be defined in this argument, or defined in the
`vcl` argument below
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Bigqueryloggings</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1bigquerylogging">List&lt;Servicev1Bigquerylogging<wbr>Args&gt;?</a></span>
    </dt>
    <dd>{{% md %}}A BigQuery endpoint to send streaming logs too.
Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Blobstorageloggings</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1blobstoragelogging">List&lt;Servicev1Blobstoragelogging<wbr>Args&gt;?</a></span>
    </dt>
    <dd>{{% md %}}An Azure Blob Storage endpoint to send streaming logs too.
Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Cache<wbr>Settings</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1cachesetting">List&lt;Servicev1Cache<wbr>Setting<wbr>Args&gt;?</a></span>
    </dt>
    <dd>{{% md %}}A set of Cache Settings, allowing you to override
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Cloned<wbr>Version</span>
        <span class="property-indicator"></span>
        <span class="property-type">int?</span>
    </dt>
    <dd>{{% md %}}{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Comment</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}An optional comment about the Director.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Conditions</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1condition">List&lt;Servicev1Condition<wbr>Args&gt;?</a></span>
    </dt>
    <dd>{{% md %}}A set of conditions to add logic to any basic
configuration object in this service. Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Default<wbr>Host</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}Sets the host header.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Default<wbr>Ttl</span>
        <span class="property-indicator"></span>
        <span class="property-type">int?</span>
    </dt>
    <dd>{{% md %}}The default Time-to-live (TTL) for
requests.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Dictionaries</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1dictionary">List&lt;Servicev1Dictionary<wbr>Args&gt;?</a></span>
    </dt>
    <dd>{{% md %}}A set of dictionaries that allow the storing of key values pair for use within VCL functions. Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Directors</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1director">List&lt;Servicev1Director<wbr>Args&gt;?</a></span>
    </dt>
    <dd>{{% md %}}A director to allow more control over balancing traffic over backends.
when an item is not to be cached based on an above `condition`. Defined below
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Domains</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1domain">List&lt;Servicev1Domain<wbr>Args&gt;?</a></span>
    </dt>
    <dd>{{% md %}}If you created the S3 bucket outside of `us-east-1`,
then specify the corresponding bucket endpoint. Example: `s3-us-west-2.amazonaws.com`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Dynamicsnippets</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1dynamicsnippet">List&lt;Servicev1Dynamicsnippet<wbr>Args&gt;?</a></span>
    </dt>
    <dd>{{% md %}}A set of custom, "dynamic" VCL Snippet configuration blocks.  Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Force<wbr>Destroy</span>
        <span class="property-indicator"></span>
        <span class="property-type">bool?</span>
    </dt>
    <dd>{{% md %}}Services that are active cannot be destroyed. In
order to destroy the Service, set `force_destroy` to `true`. Default `false`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Gcsloggings</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1gcslogging">List&lt;Servicev1Gcslogging<wbr>Args&gt;?</a></span>
    </dt>
    <dd>{{% md %}}A gcs endpoint to send streaming logs too.
Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Gzips</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1gzip">List&lt;Servicev1Gzip<wbr>Args&gt;?</a></span>
    </dt>
    <dd>{{% md %}}A set of gzip rules to control automatic gzipping of
content. Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Headers</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1header">List&lt;Servicev1Header<wbr>Args&gt;?</a></span>
    </dt>
    <dd>{{% md %}}A set of Headers to manipulate for each request. Defined
below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Healthchecks</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1healthcheck">List&lt;Servicev1Healthcheck<wbr>Args&gt;?</a></span>
    </dt>
    <dd>{{% md %}}Name of a defined `healthcheck` to assign to this backend.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Logentries</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1logentry">List&lt;Servicev1Logentry<wbr>Args&gt;?</a></span>
    </dt>
    <dd>{{% md %}}A logentries endpoint to send streaming logs too.
Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Name</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}A unique name to identify this dictionary.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Papertrails</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1papertrail">List&lt;Servicev1Papertrail<wbr>Args&gt;?</a></span>
    </dt>
    <dd>{{% md %}}A Papertrail endpoint to send streaming logs too.
Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Request<wbr>Settings</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1requestsetting">List&lt;Servicev1Request<wbr>Setting<wbr>Args&gt;?</a></span>
    </dt>
    <dd>{{% md %}}A set of Request modifiers. Defined below
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Response<wbr>Objects</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1responseobject">List&lt;Servicev1Response<wbr>Object<wbr>Args&gt;?</a></span>
    </dt>
    <dd>{{% md %}}Allows you to create synthetic responses that exist entirely on the varnish machine. Useful for creating error or maintenance pages that exists outside the scope of your datacenter. Best when used with Condition objects.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>S3loggings</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1s3logging">List&lt;Servicev1S3logging<wbr>Args&gt;?</a></span>
    </dt>
    <dd>{{% md %}}A set of S3 Buckets to send streaming logs too.
Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Snippets</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1snippet">List&lt;Servicev1Snippet<wbr>Args&gt;?</a></span>
    </dt>
    <dd>{{% md %}}A set of custom, "regular" (non-dynamic) VCL Snippet configuration blocks.  Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Splunks</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1splunk">List&lt;Servicev1Splunk<wbr>Args&gt;?</a></span>
    </dt>
    <dd>{{% md %}}A Splunk endpoint to send streaming logs too.
Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Sumologics</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1sumologic">List&lt;Servicev1Sumologic<wbr>Args&gt;?</a></span>
    </dt>
    <dd>{{% md %}}A Sumologic endpoint to send streaming logs too.
Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Syslogs</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1syslog">List&lt;Servicev1Syslog<wbr>Args&gt;?</a></span>
    </dt>
    <dd>{{% md %}}A syslog endpoint to send streaming logs too.
Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Vcls</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1vcl">List&lt;Servicev1Vcl<wbr>Args&gt;?</a></span>
    </dt>
    <dd>{{% md %}}A set of custom VCL configuration blocks. The
ability to upload custom VCL code is not enabled by default for new Fastly
accounts (see the [Fastly documentation](https://docs.fastly.com/guides/vcl/uploading-custom-vcl) for details).
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Version<wbr>Comment</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}Description field for the version.
{{% /md %}}</dd>

</dl>
{{% /choosable %}}


{{% choosable language go %}}
<dl class="resources-properties">

    <dt class="property-optional"
            title="Optional">
        <span>Acls</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1acl">[]Servicev1Acl</a></span>
    </dt>
    <dd>{{% md %}}A set of ACL configuration blocks.  Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Activate</span>
        <span class="property-indicator"></span>
        <span class="property-type">*bool</span>
    </dt>
    <dd>{{% md %}}Conditionally prevents the Service from being activated. The apply step will continue to create a new draft version but will not activate it if this is set to false. Default true.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Active<wbr>Version</span>
        <span class="property-indicator"></span>
        <span class="property-type">*int</span>
    </dt>
    <dd>{{% md %}}The currently active version of your Fastly Service.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Backends</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1backend">[]Servicev1Backend</a></span>
    </dt>
    <dd>{{% md %}}A set of Backends to service requests from your Domains.
Defined below. Backends must be defined in this argument, or defined in the
`vcl` argument below
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Bigqueryloggings</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1bigquerylogging">[]Servicev1Bigquerylogging</a></span>
    </dt>
    <dd>{{% md %}}A BigQuery endpoint to send streaming logs too.
Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Blobstorageloggings</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1blobstoragelogging">[]Servicev1Blobstoragelogging</a></span>
    </dt>
    <dd>{{% md %}}An Azure Blob Storage endpoint to send streaming logs too.
Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Cache<wbr>Settings</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1cachesetting">[]Servicev1Cache<wbr>Setting</a></span>
    </dt>
    <dd>{{% md %}}A set of Cache Settings, allowing you to override
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Cloned<wbr>Version</span>
        <span class="property-indicator"></span>
        <span class="property-type">*int</span>
    </dt>
    <dd>{{% md %}}{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Comment</span>
        <span class="property-indicator"></span>
        <span class="property-type">*string</span>
    </dt>
    <dd>{{% md %}}An optional comment about the Director.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Conditions</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1condition">[]Servicev1Condition</a></span>
    </dt>
    <dd>{{% md %}}A set of conditions to add logic to any basic
configuration object in this service. Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Default<wbr>Host</span>
        <span class="property-indicator"></span>
        <span class="property-type">*string</span>
    </dt>
    <dd>{{% md %}}Sets the host header.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Default<wbr>Ttl</span>
        <span class="property-indicator"></span>
        <span class="property-type">*int</span>
    </dt>
    <dd>{{% md %}}The default Time-to-live (TTL) for
requests.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Dictionaries</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1dictionary">[]Servicev1Dictionary</a></span>
    </dt>
    <dd>{{% md %}}A set of dictionaries that allow the storing of key values pair for use within VCL functions. Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Directors</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1director">[]Servicev1Director</a></span>
    </dt>
    <dd>{{% md %}}A director to allow more control over balancing traffic over backends.
when an item is not to be cached based on an above `condition`. Defined below
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Domains</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1domain">[]Servicev1Domain</a></span>
    </dt>
    <dd>{{% md %}}If you created the S3 bucket outside of `us-east-1`,
then specify the corresponding bucket endpoint. Example: `s3-us-west-2.amazonaws.com`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Dynamicsnippets</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1dynamicsnippet">[]Servicev1Dynamicsnippet</a></span>
    </dt>
    <dd>{{% md %}}A set of custom, "dynamic" VCL Snippet configuration blocks.  Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Force<wbr>Destroy</span>
        <span class="property-indicator"></span>
        <span class="property-type">*bool</span>
    </dt>
    <dd>{{% md %}}Services that are active cannot be destroyed. In
order to destroy the Service, set `force_destroy` to `true`. Default `false`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Gcsloggings</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1gcslogging">[]Servicev1Gcslogging</a></span>
    </dt>
    <dd>{{% md %}}A gcs endpoint to send streaming logs too.
Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Gzips</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1gzip">[]Servicev1Gzip</a></span>
    </dt>
    <dd>{{% md %}}A set of gzip rules to control automatic gzipping of
content. Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Headers</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1header">[]Servicev1Header</a></span>
    </dt>
    <dd>{{% md %}}A set of Headers to manipulate for each request. Defined
below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Healthchecks</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1healthcheck">[]Servicev1Healthcheck</a></span>
    </dt>
    <dd>{{% md %}}Name of a defined `healthcheck` to assign to this backend.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Logentries</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1logentry">[]Servicev1Logentry</a></span>
    </dt>
    <dd>{{% md %}}A logentries endpoint to send streaming logs too.
Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Name</span>
        <span class="property-indicator"></span>
        <span class="property-type">*string</span>
    </dt>
    <dd>{{% md %}}A unique name to identify this dictionary.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Papertrails</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1papertrail">[]Servicev1Papertrail</a></span>
    </dt>
    <dd>{{% md %}}A Papertrail endpoint to send streaming logs too.
Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Request<wbr>Settings</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1requestsetting">[]Servicev1Request<wbr>Setting</a></span>
    </dt>
    <dd>{{% md %}}A set of Request modifiers. Defined below
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Response<wbr>Objects</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1responseobject">[]Servicev1Response<wbr>Object</a></span>
    </dt>
    <dd>{{% md %}}Allows you to create synthetic responses that exist entirely on the varnish machine. Useful for creating error or maintenance pages that exists outside the scope of your datacenter. Best when used with Condition objects.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>S3loggings</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1s3logging">[]Servicev1S3logging</a></span>
    </dt>
    <dd>{{% md %}}A set of S3 Buckets to send streaming logs too.
Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Snippets</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1snippet">[]Servicev1Snippet</a></span>
    </dt>
    <dd>{{% md %}}A set of custom, "regular" (non-dynamic) VCL Snippet configuration blocks.  Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Splunks</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1splunk">[]Servicev1Splunk</a></span>
    </dt>
    <dd>{{% md %}}A Splunk endpoint to send streaming logs too.
Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Sumologics</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1sumologic">[]Servicev1Sumologic</a></span>
    </dt>
    <dd>{{% md %}}A Sumologic endpoint to send streaming logs too.
Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Syslogs</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1syslog">[]Servicev1Syslog</a></span>
    </dt>
    <dd>{{% md %}}A syslog endpoint to send streaming logs too.
Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Vcls</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1vcl">[]Servicev1Vcl</a></span>
    </dt>
    <dd>{{% md %}}A set of custom VCL configuration blocks. The
ability to upload custom VCL code is not enabled by default for new Fastly
accounts (see the [Fastly documentation](https://docs.fastly.com/guides/vcl/uploading-custom-vcl) for details).
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Version<wbr>Comment</span>
        <span class="property-indicator"></span>
        <span class="property-type">*string</span>
    </dt>
    <dd>{{% md %}}Description field for the version.
{{% /md %}}</dd>

</dl>
{{% /choosable %}}


{{% choosable language nodejs %}}
<dl class="resources-properties">

    <dt class="property-optional"
            title="Optional">
        <span>acls</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1acl">Servicev1Acl[]?</a></span>
    </dt>
    <dd>{{% md %}}A set of ACL configuration blocks.  Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>activate</span>
        <span class="property-indicator"></span>
        <span class="property-type">boolean?</span>
    </dt>
    <dd>{{% md %}}Conditionally prevents the Service from being activated. The apply step will continue to create a new draft version but will not activate it if this is set to false. Default true.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>active<wbr>Version</span>
        <span class="property-indicator"></span>
        <span class="property-type">number?</span>
    </dt>
    <dd>{{% md %}}The currently active version of your Fastly Service.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>backends</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1backend">Servicev1Backend[]?</a></span>
    </dt>
    <dd>{{% md %}}A set of Backends to service requests from your Domains.
Defined below. Backends must be defined in this argument, or defined in the
`vcl` argument below
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>bigqueryloggings</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1bigquerylogging">Servicev1Bigquerylogging[]?</a></span>
    </dt>
    <dd>{{% md %}}A BigQuery endpoint to send streaming logs too.
Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>blobstorageloggings</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1blobstoragelogging">Servicev1Blobstoragelogging[]?</a></span>
    </dt>
    <dd>{{% md %}}An Azure Blob Storage endpoint to send streaming logs too.
Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>cache<wbr>Settings</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1cachesetting">Servicev1Cache<wbr>Setting[]?</a></span>
    </dt>
    <dd>{{% md %}}A set of Cache Settings, allowing you to override
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>cloned<wbr>Version</span>
        <span class="property-indicator"></span>
        <span class="property-type">number?</span>
    </dt>
    <dd>{{% md %}}{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>comment</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}An optional comment about the Director.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>conditions</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1condition">Servicev1Condition[]?</a></span>
    </dt>
    <dd>{{% md %}}A set of conditions to add logic to any basic
configuration object in this service. Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>default<wbr>Host</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}Sets the host header.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>default<wbr>Ttl</span>
        <span class="property-indicator"></span>
        <span class="property-type">number?</span>
    </dt>
    <dd>{{% md %}}The default Time-to-live (TTL) for
requests.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>dictionaries</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1dictionary">Servicev1Dictionary[]?</a></span>
    </dt>
    <dd>{{% md %}}A set of dictionaries that allow the storing of key values pair for use within VCL functions. Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>directors</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1director">Servicev1Director[]?</a></span>
    </dt>
    <dd>{{% md %}}A director to allow more control over balancing traffic over backends.
when an item is not to be cached based on an above `condition`. Defined below
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>domains</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1domain">Servicev1Domain[]?</a></span>
    </dt>
    <dd>{{% md %}}If you created the S3 bucket outside of `us-east-1`,
then specify the corresponding bucket endpoint. Example: `s3-us-west-2.amazonaws.com`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>dynamicsnippets</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1dynamicsnippet">Servicev1Dynamicsnippet[]?</a></span>
    </dt>
    <dd>{{% md %}}A set of custom, "dynamic" VCL Snippet configuration blocks.  Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>force<wbr>Destroy</span>
        <span class="property-indicator"></span>
        <span class="property-type">boolean?</span>
    </dt>
    <dd>{{% md %}}Services that are active cannot be destroyed. In
order to destroy the Service, set `force_destroy` to `true`. Default `false`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>gcsloggings</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1gcslogging">Servicev1Gcslogging[]?</a></span>
    </dt>
    <dd>{{% md %}}A gcs endpoint to send streaming logs too.
Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>gzips</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1gzip">Servicev1Gzip[]?</a></span>
    </dt>
    <dd>{{% md %}}A set of gzip rules to control automatic gzipping of
content. Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>headers</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1header">Servicev1Header[]?</a></span>
    </dt>
    <dd>{{% md %}}A set of Headers to manipulate for each request. Defined
below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>healthchecks</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1healthcheck">Servicev1Healthcheck[]?</a></span>
    </dt>
    <dd>{{% md %}}Name of a defined `healthcheck` to assign to this backend.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>logentries</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1logentry">Servicev1Logentry[]?</a></span>
    </dt>
    <dd>{{% md %}}A logentries endpoint to send streaming logs too.
Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>name</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}A unique name to identify this dictionary.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>papertrails</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1papertrail">Servicev1Papertrail[]?</a></span>
    </dt>
    <dd>{{% md %}}A Papertrail endpoint to send streaming logs too.
Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>request<wbr>Settings</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1requestsetting">Servicev1Request<wbr>Setting[]?</a></span>
    </dt>
    <dd>{{% md %}}A set of Request modifiers. Defined below
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>response<wbr>Objects</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1responseobject">Servicev1Response<wbr>Object[]?</a></span>
    </dt>
    <dd>{{% md %}}Allows you to create synthetic responses that exist entirely on the varnish machine. Useful for creating error or maintenance pages that exists outside the scope of your datacenter. Best when used with Condition objects.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>s3loggings</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1s3logging">Servicev1S3logging[]?</a></span>
    </dt>
    <dd>{{% md %}}A set of S3 Buckets to send streaming logs too.
Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>snippets</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1snippet">Servicev1Snippet[]?</a></span>
    </dt>
    <dd>{{% md %}}A set of custom, "regular" (non-dynamic) VCL Snippet configuration blocks.  Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>splunks</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1splunk">Servicev1Splunk[]?</a></span>
    </dt>
    <dd>{{% md %}}A Splunk endpoint to send streaming logs too.
Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>sumologics</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1sumologic">Servicev1Sumologic[]?</a></span>
    </dt>
    <dd>{{% md %}}A Sumologic endpoint to send streaming logs too.
Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>syslogs</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1syslog">Servicev1Syslog[]?</a></span>
    </dt>
    <dd>{{% md %}}A syslog endpoint to send streaming logs too.
Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>vcls</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1vcl">Servicev1Vcl[]?</a></span>
    </dt>
    <dd>{{% md %}}A set of custom VCL configuration blocks. The
ability to upload custom VCL code is not enabled by default for new Fastly
accounts (see the [Fastly documentation](https://docs.fastly.com/guides/vcl/uploading-custom-vcl) for details).
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>version<wbr>Comment</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}Description field for the version.
{{% /md %}}</dd>

</dl>
{{% /choosable %}}


{{% choosable language python %}}
<dl class="resources-properties">

    <dt class="property-optional"
            title="Optional">
        <span>acls</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1acl">List[Servicev1Acl]</a></span>
    </dt>
    <dd>{{% md %}}A set of ACL configuration blocks.  Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>activate</span>
        <span class="property-indicator"></span>
        <span class="property-type">bool</span>
    </dt>
    <dd>{{% md %}}Conditionally prevents the Service from being activated. The apply step will continue to create a new draft version but will not activate it if this is set to false. Default true.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>active_<wbr>version</span>
        <span class="property-indicator"></span>
        <span class="property-type">float</span>
    </dt>
    <dd>{{% md %}}The currently active version of your Fastly Service.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>backends</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1backend">List[Servicev1Backend]</a></span>
    </dt>
    <dd>{{% md %}}A set of Backends to service requests from your Domains.
Defined below. Backends must be defined in this argument, or defined in the
`vcl` argument below
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>bigqueryloggings</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1bigquerylogging">List[Servicev1Bigquerylogging]</a></span>
    </dt>
    <dd>{{% md %}}A BigQuery endpoint to send streaming logs too.
Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>blobstorageloggings</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1blobstoragelogging">List[Servicev1Blobstoragelogging]</a></span>
    </dt>
    <dd>{{% md %}}An Azure Blob Storage endpoint to send streaming logs too.
Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>cache_<wbr>settings</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1cachesetting">List[Servicev1Cache<wbr>Setting]</a></span>
    </dt>
    <dd>{{% md %}}A set of Cache Settings, allowing you to override
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>cloned_<wbr>version</span>
        <span class="property-indicator"></span>
        <span class="property-type">float</span>
    </dt>
    <dd>{{% md %}}{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>comment</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}An optional comment about the Director.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>conditions</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1condition">List[Servicev1Condition]</a></span>
    </dt>
    <dd>{{% md %}}A set of conditions to add logic to any basic
configuration object in this service. Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>default_<wbr>host</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}Sets the host header.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>default_<wbr>ttl</span>
        <span class="property-indicator"></span>
        <span class="property-type">float</span>
    </dt>
    <dd>{{% md %}}The default Time-to-live (TTL) for
requests.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>dictionaries</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1dictionary">List[Servicev1Dictionary]</a></span>
    </dt>
    <dd>{{% md %}}A set of dictionaries that allow the storing of key values pair for use within VCL functions. Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>directors</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1director">List[Servicev1Director]</a></span>
    </dt>
    <dd>{{% md %}}A director to allow more control over balancing traffic over backends.
when an item is not to be cached based on an above `condition`. Defined below
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>domains</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1domain">List[Servicev1Domain]</a></span>
    </dt>
    <dd>{{% md %}}If you created the S3 bucket outside of `us-east-1`,
then specify the corresponding bucket endpoint. Example: `s3-us-west-2.amazonaws.com`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>dynamicsnippets</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1dynamicsnippet">List[Servicev1Dynamicsnippet]</a></span>
    </dt>
    <dd>{{% md %}}A set of custom, "dynamic" VCL Snippet configuration blocks.  Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>force_<wbr>destroy</span>
        <span class="property-indicator"></span>
        <span class="property-type">bool</span>
    </dt>
    <dd>{{% md %}}Services that are active cannot be destroyed. In
order to destroy the Service, set `force_destroy` to `true`. Default `false`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>gcsloggings</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1gcslogging">List[Servicev1Gcslogging]</a></span>
    </dt>
    <dd>{{% md %}}A gcs endpoint to send streaming logs too.
Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>gzips</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1gzip">List[Servicev1Gzip]</a></span>
    </dt>
    <dd>{{% md %}}A set of gzip rules to control automatic gzipping of
content. Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>headers</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1header">List[Servicev1Header]</a></span>
    </dt>
    <dd>{{% md %}}A set of Headers to manipulate for each request. Defined
below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>healthchecks</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1healthcheck">List[Servicev1Healthcheck]</a></span>
    </dt>
    <dd>{{% md %}}Name of a defined `healthcheck` to assign to this backend.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>logentries</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1logentry">List[Servicev1Logentry]</a></span>
    </dt>
    <dd>{{% md %}}A logentries endpoint to send streaming logs too.
Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>name</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}A unique name to identify this dictionary.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>papertrails</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1papertrail">List[Servicev1Papertrail]</a></span>
    </dt>
    <dd>{{% md %}}A Papertrail endpoint to send streaming logs too.
Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>request_<wbr>settings</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1requestsetting">List[Servicev1Request<wbr>Setting]</a></span>
    </dt>
    <dd>{{% md %}}A set of Request modifiers. Defined below
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>response_<wbr>objects</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1responseobject">List[Servicev1Response<wbr>Object]</a></span>
    </dt>
    <dd>{{% md %}}Allows you to create synthetic responses that exist entirely on the varnish machine. Useful for creating error or maintenance pages that exists outside the scope of your datacenter. Best when used with Condition objects.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>s3loggings</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1s3logging">List[Servicev1S3logging]</a></span>
    </dt>
    <dd>{{% md %}}A set of S3 Buckets to send streaming logs too.
Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>snippets</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1snippet">List[Servicev1Snippet]</a></span>
    </dt>
    <dd>{{% md %}}A set of custom, "regular" (non-dynamic) VCL Snippet configuration blocks.  Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>splunks</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1splunk">List[Servicev1Splunk]</a></span>
    </dt>
    <dd>{{% md %}}A Splunk endpoint to send streaming logs too.
Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>sumologics</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1sumologic">List[Servicev1Sumologic]</a></span>
    </dt>
    <dd>{{% md %}}A Sumologic endpoint to send streaming logs too.
Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>syslogs</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1syslog">List[Servicev1Syslog]</a></span>
    </dt>
    <dd>{{% md %}}A syslog endpoint to send streaming logs too.
Defined below.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>vcls</span>
        <span class="property-indicator"></span>
        <span class="property-type"><a href="#servicev1vcl">List[Servicev1Vcl]</a></span>
    </dt>
    <dd>{{% md %}}A set of custom VCL configuration blocks. The
ability to upload custom VCL code is not enabled by default for new Fastly
accounts (see the [Fastly documentation](https://docs.fastly.com/guides/vcl/uploading-custom-vcl) for details).
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>version_<wbr>comment</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}Description field for the version.
{{% /md %}}</dd>

</dl>
{{% /choosable %}}










## Supporting Types

<h4>Servicev1Acl</h4>
{{% choosable language nodejs %}}
> See the <a href="/docs/reference/pkg/nodejs/pulumi/fastly/types/input/#Servicev1Acl">input</a> and <a href="/docs/reference/pkg/nodejs/pulumi/fastly/types/output/#Servicev1Acl">output</a> API doc for this type.
{{% /choosable %}}

{{% choosable language go %}}
> See the <a href="https://pkg.go.dev/github.com/pulumi/pulumi-fastly/sdk/go/fastly/?tab=doc#Servicev1AclArgs">input</a> and <a href="https://pkg.go.dev/github.com/pulumi/pulumi-fastly/sdk/go/fastly/?tab=doc#Servicev1AclOutput">output</a> API doc for this type.
{{% /choosable %}}




{{% choosable language csharp %}}
<dl class="resources-properties">

    <dt class="property-optional"
            title="Optional">
        <span>Acl<wbr>Id</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}The ID of the ACL.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>Name</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}A unique name to identify this dictionary.
{{% /md %}}</dd>

</dl>
{{% /choosable %}}


{{% choosable language go %}}
<dl class="resources-properties">

    <dt class="property-optional"
            title="Optional">
        <span>Acl<wbr>Id</span>
        <span class="property-indicator"></span>
        <span class="property-type">*string</span>
    </dt>
    <dd>{{% md %}}The ID of the ACL.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>Name</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}A unique name to identify this dictionary.
{{% /md %}}</dd>

</dl>
{{% /choosable %}}


{{% choosable language nodejs %}}
<dl class="resources-properties">

    <dt class="property-optional"
            title="Optional">
        <span>acl<wbr>Id</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}The ID of the ACL.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>name</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}A unique name to identify this dictionary.
{{% /md %}}</dd>

</dl>
{{% /choosable %}}


{{% choosable language python %}}
<dl class="resources-properties">

    <dt class="property-optional"
            title="Optional">
        <span>acl_<wbr>id</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}The ID of the ACL.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>name</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}A unique name to identify this dictionary.
{{% /md %}}</dd>

</dl>
{{% /choosable %}}





<h4>Servicev1Backend</h4>
{{% choosable language nodejs %}}
> See the <a href="/docs/reference/pkg/nodejs/pulumi/fastly/types/input/#Servicev1Backend">input</a> and <a href="/docs/reference/pkg/nodejs/pulumi/fastly/types/output/#Servicev1Backend">output</a> API doc for this type.
{{% /choosable %}}

{{% choosable language go %}}
> See the <a href="https://pkg.go.dev/github.com/pulumi/pulumi-fastly/sdk/go/fastly/?tab=doc#Servicev1BackendArgs">input</a> and <a href="https://pkg.go.dev/github.com/pulumi/pulumi-fastly/sdk/go/fastly/?tab=doc#Servicev1BackendOutput">output</a> API doc for this type.
{{% /choosable %}}




{{% choosable language csharp %}}
<dl class="resources-properties">

    <dt class="property-required"
            title="Required">
        <span>Address</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}A hostname or IPv4 address of the Syslog endpoint.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Auto<wbr>Loadbalance</span>
        <span class="property-indicator"></span>
        <span class="property-type">bool?</span>
    </dt>
    <dd>{{% md %}}Denotes if this Backend should be
included in the pool of backends that requests are load balanced against.
Default `true`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Between<wbr>Bytes<wbr>Timeout</span>
        <span class="property-indicator"></span>
        <span class="property-type">int?</span>
    </dt>
    <dd>{{% md %}}How long to wait between bytes in milliseconds. Default `10000`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Connect<wbr>Timeout</span>
        <span class="property-indicator"></span>
        <span class="property-type">int?</span>
    </dt>
    <dd>{{% md %}}How long to wait for a timeout in milliseconds.
Default `1000`
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Error<wbr>Threshold</span>
        <span class="property-indicator"></span>
        <span class="property-type">int?</span>
    </dt>
    <dd>{{% md %}}Number of errors to allow before the Backend is marked as down. Default `0`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>First<wbr>Byte<wbr>Timeout</span>
        <span class="property-indicator"></span>
        <span class="property-type">int?</span>
    </dt>
    <dd>{{% md %}}How long to wait for the first bytes in milliseconds. Default `15000`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Healthcheck</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}Name of a defined `healthcheck` to assign to this backend.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Max<wbr>Conn</span>
        <span class="property-indicator"></span>
        <span class="property-type">int?</span>
    </dt>
    <dd>{{% md %}}Maximum number of connections for this Backend.
Default `200`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Max<wbr>Tls<wbr>Version</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}Maximum allowed TLS version on SSL connections to this backend.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Min<wbr>Tls<wbr>Version</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}Minimum allowed TLS version on SSL connections to this backend.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>Name</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}A unique name to identify this dictionary.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Override<wbr>Host</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}The hostname to override the Host header.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Port</span>
        <span class="property-indicator"></span>
        <span class="property-type">int?</span>
    </dt>
    <dd>{{% md %}}The port number configured in Logentries to send logs to. Defaults to `20000`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Request<wbr>Condition</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}Name of already defined `condition` to be checked during the request phase. If the condition passes then this object will be delivered. This `condition` must be of type `REQUEST`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Shield</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}Selected POP to serve as a "shield" for origin servers.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Ssl<wbr>Ca<wbr>Cert</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}CA certificate attached to origin.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Ssl<wbr>Cert<wbr>Hostname</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}Overrides ssl_hostname, but only for cert verification. Does not affect SNI at all.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Ssl<wbr>Check<wbr>Cert</span>
        <span class="property-indicator"></span>
        <span class="property-type">bool?</span>
    </dt>
    <dd>{{% md %}}Be strict about checking SSL certs. Default `true`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Ssl<wbr>Ciphers</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}Comma separated list of OpenSSL Ciphers to try when negotiating to the backend.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Ssl<wbr>Client<wbr>Cert</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}Client certificate attached to origin. Used when connecting to the backend.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Ssl<wbr>Client<wbr>Key</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}Client key attached to origin. Used when connecting to the backend.
{{% /md %}}</dd>

    <dt class="property-optional property-deprecated"
            title="Optional, Deprecated">
        <span>Ssl<wbr>Hostname</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}Used for both SNI during the TLS handshake and to validate the cert.
{{% /md %}}<p class="property-message">Deprecated: {{% md %}}Use ssl_cert_hostname and ssl_sni_hostname instead.{{% /md %}}</p></dd>

    <dt class="property-optional"
            title="Optional">
        <span>Ssl<wbr>Sni<wbr>Hostname</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}Overrides ssl_hostname, but only for SNI in the handshake. Does not affect cert validation at all.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Use<wbr>Ssl</span>
        <span class="property-indicator"></span>
        <span class="property-type">bool?</span>
    </dt>
    <dd>{{% md %}}Whether or not to use SSL to reach the backend. Default `false`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Weight</span>
        <span class="property-indicator"></span>
        <span class="property-type">int?</span>
    </dt>
    <dd>{{% md %}}The [portion of traffic](https://docs.fastly.com/guides/performance-tuning/load-balancing-configuration.html#how-weight-affects-load-balancing) to send to this Backend. Each Backend receives `weight / total` of the traffic. Default `100`.
{{% /md %}}</dd>

</dl>
{{% /choosable %}}


{{% choosable language go %}}
<dl class="resources-properties">

    <dt class="property-required"
            title="Required">
        <span>Address</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}A hostname or IPv4 address of the Syslog endpoint.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Auto<wbr>Loadbalance</span>
        <span class="property-indicator"></span>
        <span class="property-type">*bool</span>
    </dt>
    <dd>{{% md %}}Denotes if this Backend should be
included in the pool of backends that requests are load balanced against.
Default `true`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Between<wbr>Bytes<wbr>Timeout</span>
        <span class="property-indicator"></span>
        <span class="property-type">*int</span>
    </dt>
    <dd>{{% md %}}How long to wait between bytes in milliseconds. Default `10000`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Connect<wbr>Timeout</span>
        <span class="property-indicator"></span>
        <span class="property-type">*int</span>
    </dt>
    <dd>{{% md %}}How long to wait for a timeout in milliseconds.
Default `1000`
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Error<wbr>Threshold</span>
        <span class="property-indicator"></span>
        <span class="property-type">*int</span>
    </dt>
    <dd>{{% md %}}Number of errors to allow before the Backend is marked as down. Default `0`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>First<wbr>Byte<wbr>Timeout</span>
        <span class="property-indicator"></span>
        <span class="property-type">*int</span>
    </dt>
    <dd>{{% md %}}How long to wait for the first bytes in milliseconds. Default `15000`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Healthcheck</span>
        <span class="property-indicator"></span>
        <span class="property-type">*string</span>
    </dt>
    <dd>{{% md %}}Name of a defined `healthcheck` to assign to this backend.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Max<wbr>Conn</span>
        <span class="property-indicator"></span>
        <span class="property-type">*int</span>
    </dt>
    <dd>{{% md %}}Maximum number of connections for this Backend.
Default `200`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Max<wbr>Tls<wbr>Version</span>
        <span class="property-indicator"></span>
        <span class="property-type">*string</span>
    </dt>
    <dd>{{% md %}}Maximum allowed TLS version on SSL connections to this backend.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Min<wbr>Tls<wbr>Version</span>
        <span class="property-indicator"></span>
        <span class="property-type">*string</span>
    </dt>
    <dd>{{% md %}}Minimum allowed TLS version on SSL connections to this backend.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>Name</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}A unique name to identify this dictionary.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Override<wbr>Host</span>
        <span class="property-indicator"></span>
        <span class="property-type">*string</span>
    </dt>
    <dd>{{% md %}}The hostname to override the Host header.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Port</span>
        <span class="property-indicator"></span>
        <span class="property-type">*int</span>
    </dt>
    <dd>{{% md %}}The port number configured in Logentries to send logs to. Defaults to `20000`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Request<wbr>Condition</span>
        <span class="property-indicator"></span>
        <span class="property-type">*string</span>
    </dt>
    <dd>{{% md %}}Name of already defined `condition` to be checked during the request phase. If the condition passes then this object will be delivered. This `condition` must be of type `REQUEST`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Shield</span>
        <span class="property-indicator"></span>
        <span class="property-type">*string</span>
    </dt>
    <dd>{{% md %}}Selected POP to serve as a "shield" for origin servers.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Ssl<wbr>Ca<wbr>Cert</span>
        <span class="property-indicator"></span>
        <span class="property-type">*string</span>
    </dt>
    <dd>{{% md %}}CA certificate attached to origin.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Ssl<wbr>Cert<wbr>Hostname</span>
        <span class="property-indicator"></span>
        <span class="property-type">*string</span>
    </dt>
    <dd>{{% md %}}Overrides ssl_hostname, but only for cert verification. Does not affect SNI at all.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Ssl<wbr>Check<wbr>Cert</span>
        <span class="property-indicator"></span>
        <span class="property-type">*bool</span>
    </dt>
    <dd>{{% md %}}Be strict about checking SSL certs. Default `true`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Ssl<wbr>Ciphers</span>
        <span class="property-indicator"></span>
        <span class="property-type">*string</span>
    </dt>
    <dd>{{% md %}}Comma separated list of OpenSSL Ciphers to try when negotiating to the backend.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Ssl<wbr>Client<wbr>Cert</span>
        <span class="property-indicator"></span>
        <span class="property-type">*string</span>
    </dt>
    <dd>{{% md %}}Client certificate attached to origin. Used when connecting to the backend.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Ssl<wbr>Client<wbr>Key</span>
        <span class="property-indicator"></span>
        <span class="property-type">*string</span>
    </dt>
    <dd>{{% md %}}Client key attached to origin. Used when connecting to the backend.
{{% /md %}}</dd>

    <dt class="property-optional property-deprecated"
            title="Optional, Deprecated">
        <span>Ssl<wbr>Hostname</span>
        <span class="property-indicator"></span>
        <span class="property-type">*string</span>
    </dt>
    <dd>{{% md %}}Used for both SNI during the TLS handshake and to validate the cert.
{{% /md %}}<p class="property-message">Deprecated: {{% md %}}Use ssl_cert_hostname and ssl_sni_hostname instead.{{% /md %}}</p></dd>

    <dt class="property-optional"
            title="Optional">
        <span>Ssl<wbr>Sni<wbr>Hostname</span>
        <span class="property-indicator"></span>
        <span class="property-type">*string</span>
    </dt>
    <dd>{{% md %}}Overrides ssl_hostname, but only for SNI in the handshake. Does not affect cert validation at all.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Use<wbr>Ssl</span>
        <span class="property-indicator"></span>
        <span class="property-type">*bool</span>
    </dt>
    <dd>{{% md %}}Whether or not to use SSL to reach the backend. Default `false`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Weight</span>
        <span class="property-indicator"></span>
        <span class="property-type">*int</span>
    </dt>
    <dd>{{% md %}}The [portion of traffic](https://docs.fastly.com/guides/performance-tuning/load-balancing-configuration.html#how-weight-affects-load-balancing) to send to this Backend. Each Backend receives `weight / total` of the traffic. Default `100`.
{{% /md %}}</dd>

</dl>
{{% /choosable %}}


{{% choosable language nodejs %}}
<dl class="resources-properties">

    <dt class="property-required"
            title="Required">
        <span>address</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}A hostname or IPv4 address of the Syslog endpoint.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>auto<wbr>Loadbalance</span>
        <span class="property-indicator"></span>
        <span class="property-type">boolean?</span>
    </dt>
    <dd>{{% md %}}Denotes if this Backend should be
included in the pool of backends that requests are load balanced against.
Default `true`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>between<wbr>Bytes<wbr>Timeout</span>
        <span class="property-indicator"></span>
        <span class="property-type">number?</span>
    </dt>
    <dd>{{% md %}}How long to wait between bytes in milliseconds. Default `10000`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>connect<wbr>Timeout</span>
        <span class="property-indicator"></span>
        <span class="property-type">number?</span>
    </dt>
    <dd>{{% md %}}How long to wait for a timeout in milliseconds.
Default `1000`
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>error<wbr>Threshold</span>
        <span class="property-indicator"></span>
        <span class="property-type">number?</span>
    </dt>
    <dd>{{% md %}}Number of errors to allow before the Backend is marked as down. Default `0`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>first<wbr>Byte<wbr>Timeout</span>
        <span class="property-indicator"></span>
        <span class="property-type">number?</span>
    </dt>
    <dd>{{% md %}}How long to wait for the first bytes in milliseconds. Default `15000`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>healthcheck</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}Name of a defined `healthcheck` to assign to this backend.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>max<wbr>Conn</span>
        <span class="property-indicator"></span>
        <span class="property-type">number?</span>
    </dt>
    <dd>{{% md %}}Maximum number of connections for this Backend.
Default `200`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>max<wbr>Tls<wbr>Version</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}Maximum allowed TLS version on SSL connections to this backend.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>min<wbr>Tls<wbr>Version</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}Minimum allowed TLS version on SSL connections to this backend.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>name</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}A unique name to identify this dictionary.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>override<wbr>Host</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}The hostname to override the Host header.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>port</span>
        <span class="property-indicator"></span>
        <span class="property-type">number?</span>
    </dt>
    <dd>{{% md %}}The port number configured in Logentries to send logs to. Defaults to `20000`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>request<wbr>Condition</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}Name of already defined `condition` to be checked during the request phase. If the condition passes then this object will be delivered. This `condition` must be of type `REQUEST`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>shield</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}Selected POP to serve as a "shield" for origin servers.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>ssl<wbr>Ca<wbr>Cert</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}CA certificate attached to origin.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>ssl<wbr>Cert<wbr>Hostname</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}Overrides ssl_hostname, but only for cert verification. Does not affect SNI at all.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>ssl<wbr>Check<wbr>Cert</span>
        <span class="property-indicator"></span>
        <span class="property-type">boolean?</span>
    </dt>
    <dd>{{% md %}}Be strict about checking SSL certs. Default `true`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>ssl<wbr>Ciphers</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}Comma separated list of OpenSSL Ciphers to try when negotiating to the backend.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>ssl<wbr>Client<wbr>Cert</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}Client certificate attached to origin. Used when connecting to the backend.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>ssl<wbr>Client<wbr>Key</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}Client key attached to origin. Used when connecting to the backend.
{{% /md %}}</dd>

    <dt class="property-optional property-deprecated"
            title="Optional, Deprecated">
        <span>ssl<wbr>Hostname</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}Used for both SNI during the TLS handshake and to validate the cert.
{{% /md %}}<p class="property-message">Deprecated: {{% md %}}Use ssl_cert_hostname and ssl_sni_hostname instead.{{% /md %}}</p></dd>

    <dt class="property-optional"
            title="Optional">
        <span>ssl<wbr>Sni<wbr>Hostname</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}Overrides ssl_hostname, but only for SNI in the handshake. Does not affect cert validation at all.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>use<wbr>Ssl</span>
        <span class="property-indicator"></span>
        <span class="property-type">boolean?</span>
    </dt>
    <dd>{{% md %}}Whether or not to use SSL to reach the backend. Default `false`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>weight</span>
        <span class="property-indicator"></span>
        <span class="property-type">number?</span>
    </dt>
    <dd>{{% md %}}The [portion of traffic](https://docs.fastly.com/guides/performance-tuning/load-balancing-configuration.html#how-weight-affects-load-balancing) to send to this Backend. Each Backend receives `weight / total` of the traffic. Default `100`.
{{% /md %}}</dd>

</dl>
{{% /choosable %}}


{{% choosable language python %}}
<dl class="resources-properties">

    <dt class="property-required"
            title="Required">
        <span>address</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}A hostname or IPv4 address of the Syslog endpoint.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>auto<wbr>Loadbalance</span>
        <span class="property-indicator"></span>
        <span class="property-type">bool</span>
    </dt>
    <dd>{{% md %}}Denotes if this Backend should be
included in the pool of backends that requests are load balanced against.
Default `true`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>between<wbr>Bytes<wbr>Timeout</span>
        <span class="property-indicator"></span>
        <span class="property-type">float</span>
    </dt>
    <dd>{{% md %}}How long to wait between bytes in milliseconds. Default `10000`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>connect<wbr>Timeout</span>
        <span class="property-indicator"></span>
        <span class="property-type">float</span>
    </dt>
    <dd>{{% md %}}How long to wait for a timeout in milliseconds.
Default `1000`
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>error<wbr>Threshold</span>
        <span class="property-indicator"></span>
        <span class="property-type">float</span>
    </dt>
    <dd>{{% md %}}Number of errors to allow before the Backend is marked as down. Default `0`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>first<wbr>Byte<wbr>Timeout</span>
        <span class="property-indicator"></span>
        <span class="property-type">float</span>
    </dt>
    <dd>{{% md %}}How long to wait for the first bytes in milliseconds. Default `15000`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>healthcheck</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}Name of a defined `healthcheck` to assign to this backend.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>max<wbr>Conn</span>
        <span class="property-indicator"></span>
        <span class="property-type">float</span>
    </dt>
    <dd>{{% md %}}Maximum number of connections for this Backend.
Default `200`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>max<wbr>Tls<wbr>Version</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}Maximum allowed TLS version on SSL connections to this backend.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>min<wbr>Tls<wbr>Version</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}Minimum allowed TLS version on SSL connections to this backend.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>name</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}A unique name to identify this dictionary.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>override<wbr>Host</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}The hostname to override the Host header.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>port</span>
        <span class="property-indicator"></span>
        <span class="property-type">float</span>
    </dt>
    <dd>{{% md %}}The port number configured in Logentries to send logs to. Defaults to `20000`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>request<wbr>Condition</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}Name of already defined `condition` to be checked during the request phase. If the condition passes then this object will be delivered. This `condition` must be of type `REQUEST`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>shield</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}Selected POP to serve as a "shield" for origin servers.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>ssl<wbr>Ca<wbr>Cert</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}CA certificate attached to origin.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>ssl<wbr>Cert<wbr>Hostname</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}Overrides ssl_hostname, but only for cert verification. Does not affect SNI at all.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>ssl<wbr>Check<wbr>Cert</span>
        <span class="property-indicator"></span>
        <span class="property-type">bool</span>
    </dt>
    <dd>{{% md %}}Be strict about checking SSL certs. Default `true`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>ssl<wbr>Ciphers</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}Comma separated list of OpenSSL Ciphers to try when negotiating to the backend.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>ssl<wbr>Client<wbr>Cert</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}Client certificate attached to origin. Used when connecting to the backend.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>ssl<wbr>Client<wbr>Key</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}Client key attached to origin. Used when connecting to the backend.
{{% /md %}}</dd>

    <dt class="property-optional property-deprecated"
            title="Optional, Deprecated">
        <span>ssl<wbr>Hostname</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}Used for both SNI during the TLS handshake and to validate the cert.
{{% /md %}}<p class="property-message">Deprecated: {{% md %}}Use ssl_cert_hostname and ssl_sni_hostname instead.{{% /md %}}</p></dd>

    <dt class="property-optional"
            title="Optional">
        <span>ssl<wbr>Sni<wbr>Hostname</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}Overrides ssl_hostname, but only for SNI in the handshake. Does not affect cert validation at all.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>use<wbr>Ssl</span>
        <span class="property-indicator"></span>
        <span class="property-type">bool</span>
    </dt>
    <dd>{{% md %}}Whether or not to use SSL to reach the backend. Default `false`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>weight</span>
        <span class="property-indicator"></span>
        <span class="property-type">float</span>
    </dt>
    <dd>{{% md %}}The [portion of traffic](https://docs.fastly.com/guides/performance-tuning/load-balancing-configuration.html#how-weight-affects-load-balancing) to send to this Backend. Each Backend receives `weight / total` of the traffic. Default `100`.
{{% /md %}}</dd>

</dl>
{{% /choosable %}}





<h4>Servicev1Bigquerylogging</h4>
{{% choosable language nodejs %}}
> See the <a href="/docs/reference/pkg/nodejs/pulumi/fastly/types/input/#Servicev1Bigquerylogging">input</a> and <a href="/docs/reference/pkg/nodejs/pulumi/fastly/types/output/#Servicev1Bigquerylogging">output</a> API doc for this type.
{{% /choosable %}}

{{% choosable language go %}}
> See the <a href="https://pkg.go.dev/github.com/pulumi/pulumi-fastly/sdk/go/fastly/?tab=doc#Servicev1BigqueryloggingArgs">input</a> and <a href="https://pkg.go.dev/github.com/pulumi/pulumi-fastly/sdk/go/fastly/?tab=doc#Servicev1BigqueryloggingOutput">output</a> API doc for this type.
{{% /choosable %}}




{{% choosable language csharp %}}
<dl class="resources-properties">

    <dt class="property-required"
            title="Required">
        <span>Dataset</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}The ID of your BigQuery dataset.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Email</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}The email for the service account with write access to your BigQuery dataset. If not provided, this will be pulled from a `FASTLY_BQ_EMAIL` environment variable.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Format</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}Apache-style string or VCL variables to use for log formatting. Default `%h %l %u %t \"%r\" %>s %b`.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>Name</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}A unique name to identify this dictionary.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Placement</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}Where in the generated VCL the logging call should be placed, overriding any `format_version` default. Can be either `none` or `waf_debug`.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>Project<wbr>Id</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}The ID of your GCP project.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Response<wbr>Condition</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}The name of the `condition` to apply. If empty, always execute.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Secret<wbr>Key</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}The secret key associated with the sservice account that has write access to your BigQuery table. If not provided, this will be pulled from the `FASTLY_BQ_SECRET_KEY` environment variable. Typical format for this is a private key in a string with newlines.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>Table</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}The ID of your BigQuery table.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Template</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}Big query table name suffix template. If set will be interpreted as a strftime compatible string and used as the [Template Suffix for your table](https://cloud.google.com/bigquery/streaming-data-into-bigquery#template-tables).
{{% /md %}}</dd>

</dl>
{{% /choosable %}}


{{% choosable language go %}}
<dl class="resources-properties">

    <dt class="property-required"
            title="Required">
        <span>Dataset</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}The ID of your BigQuery dataset.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Email</span>
        <span class="property-indicator"></span>
        <span class="property-type">*string</span>
    </dt>
    <dd>{{% md %}}The email for the service account with write access to your BigQuery dataset. If not provided, this will be pulled from a `FASTLY_BQ_EMAIL` environment variable.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Format</span>
        <span class="property-indicator"></span>
        <span class="property-type">*string</span>
    </dt>
    <dd>{{% md %}}Apache-style string or VCL variables to use for log formatting. Default `%h %l %u %t \"%r\" %>s %b`.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>Name</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}A unique name to identify this dictionary.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Placement</span>
        <span class="property-indicator"></span>
        <span class="property-type">*string</span>
    </dt>
    <dd>{{% md %}}Where in the generated VCL the logging call should be placed, overriding any `format_version` default. Can be either `none` or `waf_debug`.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>Project<wbr>Id</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}The ID of your GCP project.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Response<wbr>Condition</span>
        <span class="property-indicator"></span>
        <span class="property-type">*string</span>
    </dt>
    <dd>{{% md %}}The name of the `condition` to apply. If empty, always execute.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Secret<wbr>Key</span>
        <span class="property-indicator"></span>
        <span class="property-type">*string</span>
    </dt>
    <dd>{{% md %}}The secret key associated with the sservice account that has write access to your BigQuery table. If not provided, this will be pulled from the `FASTLY_BQ_SECRET_KEY` environment variable. Typical format for this is a private key in a string with newlines.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>Table</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}The ID of your BigQuery table.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Template</span>
        <span class="property-indicator"></span>
        <span class="property-type">*string</span>
    </dt>
    <dd>{{% md %}}Big query table name suffix template. If set will be interpreted as a strftime compatible string and used as the [Template Suffix for your table](https://cloud.google.com/bigquery/streaming-data-into-bigquery#template-tables).
{{% /md %}}</dd>

</dl>
{{% /choosable %}}


{{% choosable language nodejs %}}
<dl class="resources-properties">

    <dt class="property-required"
            title="Required">
        <span>dataset</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}The ID of your BigQuery dataset.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>email</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}The email for the service account with write access to your BigQuery dataset. If not provided, this will be pulled from a `FASTLY_BQ_EMAIL` environment variable.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>format</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}Apache-style string or VCL variables to use for log formatting. Default `%h %l %u %t \"%r\" %>s %b`.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>name</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}A unique name to identify this dictionary.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>placement</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}Where in the generated VCL the logging call should be placed, overriding any `format_version` default. Can be either `none` or `waf_debug`.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>project<wbr>Id</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}The ID of your GCP project.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>response<wbr>Condition</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}The name of the `condition` to apply. If empty, always execute.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>secret<wbr>Key</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}The secret key associated with the sservice account that has write access to your BigQuery table. If not provided, this will be pulled from the `FASTLY_BQ_SECRET_KEY` environment variable. Typical format for this is a private key in a string with newlines.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>table</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}The ID of your BigQuery table.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>template</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}Big query table name suffix template. If set will be interpreted as a strftime compatible string and used as the [Template Suffix for your table](https://cloud.google.com/bigquery/streaming-data-into-bigquery#template-tables).
{{% /md %}}</dd>

</dl>
{{% /choosable %}}


{{% choosable language python %}}
<dl class="resources-properties">

    <dt class="property-required"
            title="Required">
        <span>dataset</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}The ID of your BigQuery dataset.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>email</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}The email for the service account with write access to your BigQuery dataset. If not provided, this will be pulled from a `FASTLY_BQ_EMAIL` environment variable.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>format</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}Apache-style string or VCL variables to use for log formatting. Default `%h %l %u %t \"%r\" %>s %b`.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>name</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}A unique name to identify this dictionary.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>placement</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}Where in the generated VCL the logging call should be placed, overriding any `format_version` default. Can be either `none` or `waf_debug`.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>project<wbr>Id</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}The ID of your GCP project.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>response<wbr>Condition</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}The name of the `condition` to apply. If empty, always execute.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>secret<wbr>Key</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}The secret key associated with the sservice account that has write access to your BigQuery table. If not provided, this will be pulled from the `FASTLY_BQ_SECRET_KEY` environment variable. Typical format for this is a private key in a string with newlines.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>table</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}The ID of your BigQuery table.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>template</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}Big query table name suffix template. If set will be interpreted as a strftime compatible string and used as the [Template Suffix for your table](https://cloud.google.com/bigquery/streaming-data-into-bigquery#template-tables).
{{% /md %}}</dd>

</dl>
{{% /choosable %}}





<h4>Servicev1Blobstoragelogging</h4>
{{% choosable language nodejs %}}
> See the <a href="/docs/reference/pkg/nodejs/pulumi/fastly/types/input/#Servicev1Blobstoragelogging">input</a> and <a href="/docs/reference/pkg/nodejs/pulumi/fastly/types/output/#Servicev1Blobstoragelogging">output</a> API doc for this type.
{{% /choosable %}}

{{% choosable language go %}}
> See the <a href="https://pkg.go.dev/github.com/pulumi/pulumi-fastly/sdk/go/fastly/?tab=doc#Servicev1BlobstorageloggingArgs">input</a> and <a href="https://pkg.go.dev/github.com/pulumi/pulumi-fastly/sdk/go/fastly/?tab=doc#Servicev1BlobstorageloggingOutput">output</a> API doc for this type.
{{% /choosable %}}




{{% choosable language csharp %}}
<dl class="resources-properties">

    <dt class="property-required"
            title="Required">
        <span>Account<wbr>Name</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}The unique Azure Blob Storage namespace in which your data objects are stored.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>Container</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}The name of the Azure Blob Storage container in which to store logs.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Format</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}Apache-style string or VCL variables to use for log formatting. Default `%h %l %u %t \"%r\" %>s %b`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Format<wbr>Version</span>
        <span class="property-indicator"></span>
        <span class="property-type">int?</span>
    </dt>
    <dd>{{% md %}}The version of the custom logging format used for the configured endpoint. Can be either `1` or `2`. The logging call gets placed by default in `vcl_log` if `format_version` is set to `2` and in `vcl_deliver` if `format_version` is set to `1`. Default `2`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Gzip<wbr>Level</span>
        <span class="property-indicator"></span>
        <span class="property-type">int?</span>
    </dt>
    <dd>{{% md %}}Level of GZIP compression from `0`to `9`. `0` means no compression. `1` is the fastest and the least compressed version, `9` is the slowest and the most compressed version. Default `0`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Message<wbr>Type</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}How the message should be formatted. Can be either `classic`, `loggly`, `logplex` or `blank`.  Default `classic`.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>Name</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}A unique name to identify this dictionary.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Path</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}The path to upload logs to. Must end with a trailing slash. If this field is left empty, the files will be saved in the container's root path.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Period</span>
        <span class="property-indicator"></span>
        <span class="property-type">int?</span>
    </dt>
    <dd>{{% md %}}How frequently the logs should be transferred in seconds. Default `3600`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Placement</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}Where in the generated VCL the logging call should be placed, overriding any `format_version` default. Can be either `none` or `waf_debug`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Public<wbr>Key</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}A PGP public key that Fastly will use to encrypt your log files before writing them to disk.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Response<wbr>Condition</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}The name of the `condition` to apply. If empty, always execute.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>Sas<wbr>Token</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}The Azure shared access signature providing write access to the blob service objects. Be sure to update your token before it expires or the logging functionality will not work.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Timestamp<wbr>Format</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}`strftime` specified timestamp formatting. Default `%Y-%m-%dT%H:%M:%S.000`.
{{% /md %}}</dd>

</dl>
{{% /choosable %}}


{{% choosable language go %}}
<dl class="resources-properties">

    <dt class="property-required"
            title="Required">
        <span>Account<wbr>Name</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}The unique Azure Blob Storage namespace in which your data objects are stored.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>Container</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}The name of the Azure Blob Storage container in which to store logs.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Format</span>
        <span class="property-indicator"></span>
        <span class="property-type">*string</span>
    </dt>
    <dd>{{% md %}}Apache-style string or VCL variables to use for log formatting. Default `%h %l %u %t \"%r\" %>s %b`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Format<wbr>Version</span>
        <span class="property-indicator"></span>
        <span class="property-type">*int</span>
    </dt>
    <dd>{{% md %}}The version of the custom logging format used for the configured endpoint. Can be either `1` or `2`. The logging call gets placed by default in `vcl_log` if `format_version` is set to `2` and in `vcl_deliver` if `format_version` is set to `1`. Default `2`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Gzip<wbr>Level</span>
        <span class="property-indicator"></span>
        <span class="property-type">*int</span>
    </dt>
    <dd>{{% md %}}Level of GZIP compression from `0`to `9`. `0` means no compression. `1` is the fastest and the least compressed version, `9` is the slowest and the most compressed version. Default `0`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Message<wbr>Type</span>
        <span class="property-indicator"></span>
        <span class="property-type">*string</span>
    </dt>
    <dd>{{% md %}}How the message should be formatted. Can be either `classic`, `loggly`, `logplex` or `blank`.  Default `classic`.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>Name</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}A unique name to identify this dictionary.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Path</span>
        <span class="property-indicator"></span>
        <span class="property-type">*string</span>
    </dt>
    <dd>{{% md %}}The path to upload logs to. Must end with a trailing slash. If this field is left empty, the files will be saved in the container's root path.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Period</span>
        <span class="property-indicator"></span>
        <span class="property-type">*int</span>
    </dt>
    <dd>{{% md %}}How frequently the logs should be transferred in seconds. Default `3600`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Placement</span>
        <span class="property-indicator"></span>
        <span class="property-type">*string</span>
    </dt>
    <dd>{{% md %}}Where in the generated VCL the logging call should be placed, overriding any `format_version` default. Can be either `none` or `waf_debug`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Public<wbr>Key</span>
        <span class="property-indicator"></span>
        <span class="property-type">*string</span>
    </dt>
    <dd>{{% md %}}A PGP public key that Fastly will use to encrypt your log files before writing them to disk.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Response<wbr>Condition</span>
        <span class="property-indicator"></span>
        <span class="property-type">*string</span>
    </dt>
    <dd>{{% md %}}The name of the `condition` to apply. If empty, always execute.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>Sas<wbr>Token</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}The Azure shared access signature providing write access to the blob service objects. Be sure to update your token before it expires or the logging functionality will not work.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Timestamp<wbr>Format</span>
        <span class="property-indicator"></span>
        <span class="property-type">*string</span>
    </dt>
    <dd>{{% md %}}`strftime` specified timestamp formatting. Default `%Y-%m-%dT%H:%M:%S.000`.
{{% /md %}}</dd>

</dl>
{{% /choosable %}}


{{% choosable language nodejs %}}
<dl class="resources-properties">

    <dt class="property-required"
            title="Required">
        <span>account<wbr>Name</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}The unique Azure Blob Storage namespace in which your data objects are stored.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>container</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}The name of the Azure Blob Storage container in which to store logs.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>format</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}Apache-style string or VCL variables to use for log formatting. Default `%h %l %u %t \"%r\" %>s %b`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>format<wbr>Version</span>
        <span class="property-indicator"></span>
        <span class="property-type">number?</span>
    </dt>
    <dd>{{% md %}}The version of the custom logging format used for the configured endpoint. Can be either `1` or `2`. The logging call gets placed by default in `vcl_log` if `format_version` is set to `2` and in `vcl_deliver` if `format_version` is set to `1`. Default `2`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>gzip<wbr>Level</span>
        <span class="property-indicator"></span>
        <span class="property-type">number?</span>
    </dt>
    <dd>{{% md %}}Level of GZIP compression from `0`to `9`. `0` means no compression. `1` is the fastest and the least compressed version, `9` is the slowest and the most compressed version. Default `0`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>message<wbr>Type</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}How the message should be formatted. Can be either `classic`, `loggly`, `logplex` or `blank`.  Default `classic`.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>name</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}A unique name to identify this dictionary.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>path</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}The path to upload logs to. Must end with a trailing slash. If this field is left empty, the files will be saved in the container's root path.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>period</span>
        <span class="property-indicator"></span>
        <span class="property-type">number?</span>
    </dt>
    <dd>{{% md %}}How frequently the logs should be transferred in seconds. Default `3600`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>placement</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}Where in the generated VCL the logging call should be placed, overriding any `format_version` default. Can be either `none` or `waf_debug`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>public<wbr>Key</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}A PGP public key that Fastly will use to encrypt your log files before writing them to disk.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>response<wbr>Condition</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}The name of the `condition` to apply. If empty, always execute.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>sas<wbr>Token</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}The Azure shared access signature providing write access to the blob service objects. Be sure to update your token before it expires or the logging functionality will not work.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>timestamp<wbr>Format</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}`strftime` specified timestamp formatting. Default `%Y-%m-%dT%H:%M:%S.000`.
{{% /md %}}</dd>

</dl>
{{% /choosable %}}


{{% choosable language python %}}
<dl class="resources-properties">

    <dt class="property-required"
            title="Required">
        <span>account<wbr>Name</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}The unique Azure Blob Storage namespace in which your data objects are stored.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>container</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}The name of the Azure Blob Storage container in which to store logs.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>format</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}Apache-style string or VCL variables to use for log formatting. Default `%h %l %u %t \"%r\" %>s %b`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>format<wbr>Version</span>
        <span class="property-indicator"></span>
        <span class="property-type">float</span>
    </dt>
    <dd>{{% md %}}The version of the custom logging format used for the configured endpoint. Can be either `1` or `2`. The logging call gets placed by default in `vcl_log` if `format_version` is set to `2` and in `vcl_deliver` if `format_version` is set to `1`. Default `2`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>gzip<wbr>Level</span>
        <span class="property-indicator"></span>
        <span class="property-type">float</span>
    </dt>
    <dd>{{% md %}}Level of GZIP compression from `0`to `9`. `0` means no compression. `1` is the fastest and the least compressed version, `9` is the slowest and the most compressed version. Default `0`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>message<wbr>Type</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}How the message should be formatted. Can be either `classic`, `loggly`, `logplex` or `blank`.  Default `classic`.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>name</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}A unique name to identify this dictionary.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>path</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}The path to upload logs to. Must end with a trailing slash. If this field is left empty, the files will be saved in the container's root path.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>period</span>
        <span class="property-indicator"></span>
        <span class="property-type">float</span>
    </dt>
    <dd>{{% md %}}How frequently the logs should be transferred in seconds. Default `3600`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>placement</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}Where in the generated VCL the logging call should be placed, overriding any `format_version` default. Can be either `none` or `waf_debug`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>public<wbr>Key</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}A PGP public key that Fastly will use to encrypt your log files before writing them to disk.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>response<wbr>Condition</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}The name of the `condition` to apply. If empty, always execute.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>sas<wbr>Token</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}The Azure shared access signature providing write access to the blob service objects. Be sure to update your token before it expires or the logging functionality will not work.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>timestamp<wbr>Format</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}`strftime` specified timestamp formatting. Default `%Y-%m-%dT%H:%M:%S.000`.
{{% /md %}}</dd>

</dl>
{{% /choosable %}}





<h4>Servicev1Cache<wbr>Setting</h4>
{{% choosable language nodejs %}}
> See the <a href="/docs/reference/pkg/nodejs/pulumi/fastly/types/input/#Servicev1CacheSetting">input</a> and <a href="/docs/reference/pkg/nodejs/pulumi/fastly/types/output/#Servicev1CacheSetting">output</a> API doc for this type.
{{% /choosable %}}

{{% choosable language go %}}
> See the <a href="https://pkg.go.dev/github.com/pulumi/pulumi-fastly/sdk/go/fastly/?tab=doc#Servicev1CacheSettingArgs">input</a> and <a href="https://pkg.go.dev/github.com/pulumi/pulumi-fastly/sdk/go/fastly/?tab=doc#Servicev1CacheSettingOutput">output</a> API doc for this type.
{{% /choosable %}}




{{% choosable language csharp %}}
<dl class="resources-properties">

    <dt class="property-optional"
            title="Optional">
        <span>Action</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}Allows you to terminate request handling and immediately
perform an action. When set it can be `lookup` or `pass` (Ignore the cache completely).
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Cache<wbr>Condition</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}Name of already defined `condition` to check after we have retrieved an object. If the condition passes then deliver this Request Object instead. This `condition` must be of type `CACHE`. For detailed information about Conditionals,
see [Fastly's Documentation on Conditionals][fastly-conditionals].
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>Name</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}A unique name to identify this dictionary.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Stale<wbr>Ttl</span>
        <span class="property-indicator"></span>
        <span class="property-type">int?</span>
    </dt>
    <dd>{{% md %}}Max "Time To Live" for stale (unreachable) objects.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Ttl</span>
        <span class="property-indicator"></span>
        <span class="property-type">int?</span>
    </dt>
    <dd>{{% md %}}The Time-To-Live (TTL) for the object.
{{% /md %}}</dd>

</dl>
{{% /choosable %}}


{{% choosable language go %}}
<dl class="resources-properties">

    <dt class="property-optional"
            title="Optional">
        <span>Action</span>
        <span class="property-indicator"></span>
        <span class="property-type">*string</span>
    </dt>
    <dd>{{% md %}}Allows you to terminate request handling and immediately
perform an action. When set it can be `lookup` or `pass` (Ignore the cache completely).
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Cache<wbr>Condition</span>
        <span class="property-indicator"></span>
        <span class="property-type">*string</span>
    </dt>
    <dd>{{% md %}}Name of already defined `condition` to check after we have retrieved an object. If the condition passes then deliver this Request Object instead. This `condition` must be of type `CACHE`. For detailed information about Conditionals,
see [Fastly's Documentation on Conditionals][fastly-conditionals].
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>Name</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}A unique name to identify this dictionary.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Stale<wbr>Ttl</span>
        <span class="property-indicator"></span>
        <span class="property-type">*int</span>
    </dt>
    <dd>{{% md %}}Max "Time To Live" for stale (unreachable) objects.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Ttl</span>
        <span class="property-indicator"></span>
        <span class="property-type">*int</span>
    </dt>
    <dd>{{% md %}}The Time-To-Live (TTL) for the object.
{{% /md %}}</dd>

</dl>
{{% /choosable %}}


{{% choosable language nodejs %}}
<dl class="resources-properties">

    <dt class="property-optional"
            title="Optional">
        <span>action</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}Allows you to terminate request handling and immediately
perform an action. When set it can be `lookup` or `pass` (Ignore the cache completely).
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>cache<wbr>Condition</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}Name of already defined `condition` to check after we have retrieved an object. If the condition passes then deliver this Request Object instead. This `condition` must be of type `CACHE`. For detailed information about Conditionals,
see [Fastly's Documentation on Conditionals][fastly-conditionals].
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>name</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}A unique name to identify this dictionary.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>stale<wbr>Ttl</span>
        <span class="property-indicator"></span>
        <span class="property-type">number?</span>
    </dt>
    <dd>{{% md %}}Max "Time To Live" for stale (unreachable) objects.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>ttl</span>
        <span class="property-indicator"></span>
        <span class="property-type">number?</span>
    </dt>
    <dd>{{% md %}}The Time-To-Live (TTL) for the object.
{{% /md %}}</dd>

</dl>
{{% /choosable %}}


{{% choosable language python %}}
<dl class="resources-properties">

    <dt class="property-optional"
            title="Optional">
        <span>action</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}Allows you to terminate request handling and immediately
perform an action. When set it can be `lookup` or `pass` (Ignore the cache completely).
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>cache<wbr>Condition</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}Name of already defined `condition` to check after we have retrieved an object. If the condition passes then deliver this Request Object instead. This `condition` must be of type `CACHE`. For detailed information about Conditionals,
see [Fastly's Documentation on Conditionals][fastly-conditionals].
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>name</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}A unique name to identify this dictionary.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>stale<wbr>Ttl</span>
        <span class="property-indicator"></span>
        <span class="property-type">float</span>
    </dt>
    <dd>{{% md %}}Max "Time To Live" for stale (unreachable) objects.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>ttl</span>
        <span class="property-indicator"></span>
        <span class="property-type">float</span>
    </dt>
    <dd>{{% md %}}The Time-To-Live (TTL) for the object.
{{% /md %}}</dd>

</dl>
{{% /choosable %}}





<h4>Servicev1Condition</h4>
{{% choosable language nodejs %}}
> See the <a href="/docs/reference/pkg/nodejs/pulumi/fastly/types/input/#Servicev1Condition">input</a> and <a href="/docs/reference/pkg/nodejs/pulumi/fastly/types/output/#Servicev1Condition">output</a> API doc for this type.
{{% /choosable %}}

{{% choosable language go %}}
> See the <a href="https://pkg.go.dev/github.com/pulumi/pulumi-fastly/sdk/go/fastly/?tab=doc#Servicev1ConditionArgs">input</a> and <a href="https://pkg.go.dev/github.com/pulumi/pulumi-fastly/sdk/go/fastly/?tab=doc#Servicev1ConditionOutput">output</a> API doc for this type.
{{% /choosable %}}




{{% choosable language csharp %}}
<dl class="resources-properties">

    <dt class="property-required"
            title="Required">
        <span>Name</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}A unique name to identify this dictionary.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Priority</span>
        <span class="property-indicator"></span>
        <span class="property-type">int?</span>
    </dt>
    <dd>{{% md %}}Priority determines the ordering for multiple snippets. Lower numbers execute first.  Defaults to `100`.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>Statement</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}The statement used to determine if the condition is met.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>Type</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}The location in generated VCL where the snippet should be placed (can be one of `init`, `recv`, `hit`, `miss`, `pass`, `fetch`, `error`, `deliver`, `log` or `none`).
{{% /md %}}</dd>

</dl>
{{% /choosable %}}


{{% choosable language go %}}
<dl class="resources-properties">

    <dt class="property-required"
            title="Required">
        <span>Name</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}A unique name to identify this dictionary.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Priority</span>
        <span class="property-indicator"></span>
        <span class="property-type">*int</span>
    </dt>
    <dd>{{% md %}}Priority determines the ordering for multiple snippets. Lower numbers execute first.  Defaults to `100`.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>Statement</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}The statement used to determine if the condition is met.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>Type</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}The location in generated VCL where the snippet should be placed (can be one of `init`, `recv`, `hit`, `miss`, `pass`, `fetch`, `error`, `deliver`, `log` or `none`).
{{% /md %}}</dd>

</dl>
{{% /choosable %}}


{{% choosable language nodejs %}}
<dl class="resources-properties">

    <dt class="property-required"
            title="Required">
        <span>name</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}A unique name to identify this dictionary.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>priority</span>
        <span class="property-indicator"></span>
        <span class="property-type">number?</span>
    </dt>
    <dd>{{% md %}}Priority determines the ordering for multiple snippets. Lower numbers execute first.  Defaults to `100`.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>statement</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}The statement used to determine if the condition is met.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>type</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}The location in generated VCL where the snippet should be placed (can be one of `init`, `recv`, `hit`, `miss`, `pass`, `fetch`, `error`, `deliver`, `log` or `none`).
{{% /md %}}</dd>

</dl>
{{% /choosable %}}


{{% choosable language python %}}
<dl class="resources-properties">

    <dt class="property-required"
            title="Required">
        <span>name</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}A unique name to identify this dictionary.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>priority</span>
        <span class="property-indicator"></span>
        <span class="property-type">float</span>
    </dt>
    <dd>{{% md %}}Priority determines the ordering for multiple snippets. Lower numbers execute first.  Defaults to `100`.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>statement</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}The statement used to determine if the condition is met.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>type</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}The location in generated VCL where the snippet should be placed (can be one of `init`, `recv`, `hit`, `miss`, `pass`, `fetch`, `error`, `deliver`, `log` or `none`).
{{% /md %}}</dd>

</dl>
{{% /choosable %}}





<h4>Servicev1Dictionary</h4>
{{% choosable language nodejs %}}
> See the <a href="/docs/reference/pkg/nodejs/pulumi/fastly/types/input/#Servicev1Dictionary">input</a> and <a href="/docs/reference/pkg/nodejs/pulumi/fastly/types/output/#Servicev1Dictionary">output</a> API doc for this type.
{{% /choosable %}}

{{% choosable language go %}}
> See the <a href="https://pkg.go.dev/github.com/pulumi/pulumi-fastly/sdk/go/fastly/?tab=doc#Servicev1DictionaryArgs">input</a> and <a href="https://pkg.go.dev/github.com/pulumi/pulumi-fastly/sdk/go/fastly/?tab=doc#Servicev1DictionaryOutput">output</a> API doc for this type.
{{% /choosable %}}




{{% choosable language csharp %}}
<dl class="resources-properties">

    <dt class="property-optional"
            title="Optional">
        <span>Dictionary<wbr>Id</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}The ID of the dictionary.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>Name</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}A unique name to identify this dictionary.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Write<wbr>Only</span>
        <span class="property-indicator"></span>
        <span class="property-type">bool?</span>
    </dt>
    <dd>{{% md %}}{{% /md %}}</dd>

</dl>
{{% /choosable %}}


{{% choosable language go %}}
<dl class="resources-properties">

    <dt class="property-optional"
            title="Optional">
        <span>Dictionary<wbr>Id</span>
        <span class="property-indicator"></span>
        <span class="property-type">*string</span>
    </dt>
    <dd>{{% md %}}The ID of the dictionary.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>Name</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}A unique name to identify this dictionary.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Write<wbr>Only</span>
        <span class="property-indicator"></span>
        <span class="property-type">*bool</span>
    </dt>
    <dd>{{% md %}}{{% /md %}}</dd>

</dl>
{{% /choosable %}}


{{% choosable language nodejs %}}
<dl class="resources-properties">

    <dt class="property-optional"
            title="Optional">
        <span>dictionary<wbr>Id</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}The ID of the dictionary.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>name</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}A unique name to identify this dictionary.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>write<wbr>Only</span>
        <span class="property-indicator"></span>
        <span class="property-type">boolean?</span>
    </dt>
    <dd>{{% md %}}{{% /md %}}</dd>

</dl>
{{% /choosable %}}


{{% choosable language python %}}
<dl class="resources-properties">

    <dt class="property-optional"
            title="Optional">
        <span>dictionary_<wbr>id</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}The ID of the dictionary.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>name</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}A unique name to identify this dictionary.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>write<wbr>Only</span>
        <span class="property-indicator"></span>
        <span class="property-type">bool</span>
    </dt>
    <dd>{{% md %}}{{% /md %}}</dd>

</dl>
{{% /choosable %}}





<h4>Servicev1Director</h4>
{{% choosable language nodejs %}}
> See the <a href="/docs/reference/pkg/nodejs/pulumi/fastly/types/input/#Servicev1Director">input</a> and <a href="/docs/reference/pkg/nodejs/pulumi/fastly/types/output/#Servicev1Director">output</a> API doc for this type.
{{% /choosable %}}

{{% choosable language go %}}
> See the <a href="https://pkg.go.dev/github.com/pulumi/pulumi-fastly/sdk/go/fastly/?tab=doc#Servicev1DirectorArgs">input</a> and <a href="https://pkg.go.dev/github.com/pulumi/pulumi-fastly/sdk/go/fastly/?tab=doc#Servicev1DirectorOutput">output</a> API doc for this type.
{{% /choosable %}}




{{% choosable language csharp %}}
<dl class="resources-properties">

    <dt class="property-required"
            title="Required">
        <span>Backends</span>
        <span class="property-indicator"></span>
        <span class="property-type">List<string></span>
    </dt>
    <dd>{{% md %}}Names of defined backends to map the director to. Example: `[ "origin1", "origin2" ]`
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Capacity</span>
        <span class="property-indicator"></span>
        <span class="property-type">int?</span>
    </dt>
    <dd>{{% md %}}Load balancing weight for the backends. Default `100`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Comment</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}An optional comment about the Director.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>Name</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}A unique name to identify this dictionary.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Quorum</span>
        <span class="property-indicator"></span>
        <span class="property-type">int?</span>
    </dt>
    <dd>{{% md %}}Percentage of capacity that needs to be up for the director itself to be considered up. Default `75`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Retries</span>
        <span class="property-indicator"></span>
        <span class="property-type">int?</span>
    </dt>
    <dd>{{% md %}}How many backends to search if it fails. Default `5`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Shield</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}Selected POP to serve as a "shield" for origin servers.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Type</span>
        <span class="property-indicator"></span>
        <span class="property-type">int?</span>
    </dt>
    <dd>{{% md %}}The location in generated VCL where the snippet should be placed (can be one of `init`, `recv`, `hit`, `miss`, `pass`, `fetch`, `error`, `deliver`, `log` or `none`).
{{% /md %}}</dd>

</dl>
{{% /choosable %}}


{{% choosable language go %}}
<dl class="resources-properties">

    <dt class="property-required"
            title="Required">
        <span>Backends</span>
        <span class="property-indicator"></span>
        <span class="property-type">[]string</span>
    </dt>
    <dd>{{% md %}}Names of defined backends to map the director to. Example: `[ "origin1", "origin2" ]`
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Capacity</span>
        <span class="property-indicator"></span>
        <span class="property-type">*int</span>
    </dt>
    <dd>{{% md %}}Load balancing weight for the backends. Default `100`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Comment</span>
        <span class="property-indicator"></span>
        <span class="property-type">*string</span>
    </dt>
    <dd>{{% md %}}An optional comment about the Director.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>Name</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}A unique name to identify this dictionary.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Quorum</span>
        <span class="property-indicator"></span>
        <span class="property-type">*int</span>
    </dt>
    <dd>{{% md %}}Percentage of capacity that needs to be up for the director itself to be considered up. Default `75`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Retries</span>
        <span class="property-indicator"></span>
        <span class="property-type">*int</span>
    </dt>
    <dd>{{% md %}}How many backends to search if it fails. Default `5`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Shield</span>
        <span class="property-indicator"></span>
        <span class="property-type">*string</span>
    </dt>
    <dd>{{% md %}}Selected POP to serve as a "shield" for origin servers.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Type</span>
        <span class="property-indicator"></span>
        <span class="property-type">*int</span>
    </dt>
    <dd>{{% md %}}The location in generated VCL where the snippet should be placed (can be one of `init`, `recv`, `hit`, `miss`, `pass`, `fetch`, `error`, `deliver`, `log` or `none`).
{{% /md %}}</dd>

</dl>
{{% /choosable %}}


{{% choosable language nodejs %}}
<dl class="resources-properties">

    <dt class="property-required"
            title="Required">
        <span>backends</span>
        <span class="property-indicator"></span>
        <span class="property-type">string[]</span>
    </dt>
    <dd>{{% md %}}Names of defined backends to map the director to. Example: `[ "origin1", "origin2" ]`
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>capacity</span>
        <span class="property-indicator"></span>
        <span class="property-type">number?</span>
    </dt>
    <dd>{{% md %}}Load balancing weight for the backends. Default `100`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>comment</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}An optional comment about the Director.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>name</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}A unique name to identify this dictionary.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>quorum</span>
        <span class="property-indicator"></span>
        <span class="property-type">number?</span>
    </dt>
    <dd>{{% md %}}Percentage of capacity that needs to be up for the director itself to be considered up. Default `75`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>retries</span>
        <span class="property-indicator"></span>
        <span class="property-type">number?</span>
    </dt>
    <dd>{{% md %}}How many backends to search if it fails. Default `5`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>shield</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}Selected POP to serve as a "shield" for origin servers.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>type</span>
        <span class="property-indicator"></span>
        <span class="property-type">number?</span>
    </dt>
    <dd>{{% md %}}The location in generated VCL where the snippet should be placed (can be one of `init`, `recv`, `hit`, `miss`, `pass`, `fetch`, `error`, `deliver`, `log` or `none`).
{{% /md %}}</dd>

</dl>
{{% /choosable %}}


{{% choosable language python %}}
<dl class="resources-properties">

    <dt class="property-required"
            title="Required">
        <span>backends</span>
        <span class="property-indicator"></span>
        <span class="property-type">List[str]</span>
    </dt>
    <dd>{{% md %}}Names of defined backends to map the director to. Example: `[ "origin1", "origin2" ]`
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>capacity</span>
        <span class="property-indicator"></span>
        <span class="property-type">float</span>
    </dt>
    <dd>{{% md %}}Load balancing weight for the backends. Default `100`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>comment</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}An optional comment about the Director.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>name</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}A unique name to identify this dictionary.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>quorum</span>
        <span class="property-indicator"></span>
        <span class="property-type">float</span>
    </dt>
    <dd>{{% md %}}Percentage of capacity that needs to be up for the director itself to be considered up. Default `75`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>retries</span>
        <span class="property-indicator"></span>
        <span class="property-type">float</span>
    </dt>
    <dd>{{% md %}}How many backends to search if it fails. Default `5`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>shield</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}Selected POP to serve as a "shield" for origin servers.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>type</span>
        <span class="property-indicator"></span>
        <span class="property-type">float</span>
    </dt>
    <dd>{{% md %}}The location in generated VCL where the snippet should be placed (can be one of `init`, `recv`, `hit`, `miss`, `pass`, `fetch`, `error`, `deliver`, `log` or `none`).
{{% /md %}}</dd>

</dl>
{{% /choosable %}}





<h4>Servicev1Domain</h4>
{{% choosable language nodejs %}}
> See the <a href="/docs/reference/pkg/nodejs/pulumi/fastly/types/input/#Servicev1Domain">input</a> and <a href="/docs/reference/pkg/nodejs/pulumi/fastly/types/output/#Servicev1Domain">output</a> API doc for this type.
{{% /choosable %}}

{{% choosable language go %}}
> See the <a href="https://pkg.go.dev/github.com/pulumi/pulumi-fastly/sdk/go/fastly/?tab=doc#Servicev1DomainArgs">input</a> and <a href="https://pkg.go.dev/github.com/pulumi/pulumi-fastly/sdk/go/fastly/?tab=doc#Servicev1DomainOutput">output</a> API doc for this type.
{{% /choosable %}}




{{% choosable language csharp %}}
<dl class="resources-properties">

    <dt class="property-optional"
            title="Optional">
        <span>Comment</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}An optional comment about the Director.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>Name</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}A unique name to identify this dictionary.
{{% /md %}}</dd>

</dl>
{{% /choosable %}}


{{% choosable language go %}}
<dl class="resources-properties">

    <dt class="property-optional"
            title="Optional">
        <span>Comment</span>
        <span class="property-indicator"></span>
        <span class="property-type">*string</span>
    </dt>
    <dd>{{% md %}}An optional comment about the Director.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>Name</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}A unique name to identify this dictionary.
{{% /md %}}</dd>

</dl>
{{% /choosable %}}


{{% choosable language nodejs %}}
<dl class="resources-properties">

    <dt class="property-optional"
            title="Optional">
        <span>comment</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}An optional comment about the Director.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>name</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}A unique name to identify this dictionary.
{{% /md %}}</dd>

</dl>
{{% /choosable %}}


{{% choosable language python %}}
<dl class="resources-properties">

    <dt class="property-optional"
            title="Optional">
        <span>comment</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}An optional comment about the Director.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>name</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}A unique name to identify this dictionary.
{{% /md %}}</dd>

</dl>
{{% /choosable %}}





<h4>Servicev1Dynamicsnippet</h4>
{{% choosable language nodejs %}}
> See the <a href="/docs/reference/pkg/nodejs/pulumi/fastly/types/input/#Servicev1Dynamicsnippet">input</a> and <a href="/docs/reference/pkg/nodejs/pulumi/fastly/types/output/#Servicev1Dynamicsnippet">output</a> API doc for this type.
{{% /choosable %}}

{{% choosable language go %}}
> See the <a href="https://pkg.go.dev/github.com/pulumi/pulumi-fastly/sdk/go/fastly/?tab=doc#Servicev1DynamicsnippetArgs">input</a> and <a href="https://pkg.go.dev/github.com/pulumi/pulumi-fastly/sdk/go/fastly/?tab=doc#Servicev1DynamicsnippetOutput">output</a> API doc for this type.
{{% /choosable %}}




{{% choosable language csharp %}}
<dl class="resources-properties">

    <dt class="property-required"
            title="Required">
        <span>Name</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}A unique name to identify this dictionary.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Priority</span>
        <span class="property-indicator"></span>
        <span class="property-type">int?</span>
    </dt>
    <dd>{{% md %}}Priority determines the ordering for multiple snippets. Lower numbers execute first.  Defaults to `100`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Snippet<wbr>Id</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}The ID of the dynamic snippet.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>Type</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}The location in generated VCL where the snippet should be placed (can be one of `init`, `recv`, `hit`, `miss`, `pass`, `fetch`, `error`, `deliver`, `log` or `none`).
{{% /md %}}</dd>

</dl>
{{% /choosable %}}


{{% choosable language go %}}
<dl class="resources-properties">

    <dt class="property-required"
            title="Required">
        <span>Name</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}A unique name to identify this dictionary.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Priority</span>
        <span class="property-indicator"></span>
        <span class="property-type">*int</span>
    </dt>
    <dd>{{% md %}}Priority determines the ordering for multiple snippets. Lower numbers execute first.  Defaults to `100`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Snippet<wbr>Id</span>
        <span class="property-indicator"></span>
        <span class="property-type">*string</span>
    </dt>
    <dd>{{% md %}}The ID of the dynamic snippet.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>Type</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}The location in generated VCL where the snippet should be placed (can be one of `init`, `recv`, `hit`, `miss`, `pass`, `fetch`, `error`, `deliver`, `log` or `none`).
{{% /md %}}</dd>

</dl>
{{% /choosable %}}


{{% choosable language nodejs %}}
<dl class="resources-properties">

    <dt class="property-required"
            title="Required">
        <span>name</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}A unique name to identify this dictionary.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>priority</span>
        <span class="property-indicator"></span>
        <span class="property-type">number?</span>
    </dt>
    <dd>{{% md %}}Priority determines the ordering for multiple snippets. Lower numbers execute first.  Defaults to `100`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>snippet<wbr>Id</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}The ID of the dynamic snippet.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>type</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}The location in generated VCL where the snippet should be placed (can be one of `init`, `recv`, `hit`, `miss`, `pass`, `fetch`, `error`, `deliver`, `log` or `none`).
{{% /md %}}</dd>

</dl>
{{% /choosable %}}


{{% choosable language python %}}
<dl class="resources-properties">

    <dt class="property-required"
            title="Required">
        <span>name</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}A unique name to identify this dictionary.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>priority</span>
        <span class="property-indicator"></span>
        <span class="property-type">float</span>
    </dt>
    <dd>{{% md %}}Priority determines the ordering for multiple snippets. Lower numbers execute first.  Defaults to `100`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>snippet_<wbr>id</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}The ID of the dynamic snippet.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>type</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}The location in generated VCL where the snippet should be placed (can be one of `init`, `recv`, `hit`, `miss`, `pass`, `fetch`, `error`, `deliver`, `log` or `none`).
{{% /md %}}</dd>

</dl>
{{% /choosable %}}





<h4>Servicev1Gcslogging</h4>
{{% choosable language nodejs %}}
> See the <a href="/docs/reference/pkg/nodejs/pulumi/fastly/types/input/#Servicev1Gcslogging">input</a> and <a href="/docs/reference/pkg/nodejs/pulumi/fastly/types/output/#Servicev1Gcslogging">output</a> API doc for this type.
{{% /choosable %}}

{{% choosable language go %}}
> See the <a href="https://pkg.go.dev/github.com/pulumi/pulumi-fastly/sdk/go/fastly/?tab=doc#Servicev1GcsloggingArgs">input</a> and <a href="https://pkg.go.dev/github.com/pulumi/pulumi-fastly/sdk/go/fastly/?tab=doc#Servicev1GcsloggingOutput">output</a> API doc for this type.
{{% /choosable %}}




{{% choosable language csharp %}}
<dl class="resources-properties">

    <dt class="property-required"
            title="Required">
        <span>Bucket<wbr>Name</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}The name of the bucket in which to store the logs.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Email</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}The email for the service account with write access to your BigQuery dataset. If not provided, this will be pulled from a `FASTLY_BQ_EMAIL` environment variable.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Format</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}Apache-style string or VCL variables to use for log formatting. Default `%h %l %u %t \"%r\" %>s %b`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Gzip<wbr>Level</span>
        <span class="property-indicator"></span>
        <span class="property-type">int?</span>
    </dt>
    <dd>{{% md %}}Level of GZIP compression from `0`to `9`. `0` means no compression. `1` is the fastest and the least compressed version, `9` is the slowest and the most compressed version. Default `0`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Message<wbr>Type</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}How the message should be formatted. Can be either `classic`, `loggly`, `logplex` or `blank`.  Default `classic`.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>Name</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}A unique name to identify this dictionary.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Path</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}The path to upload logs to. Must end with a trailing slash. If this field is left empty, the files will be saved in the container's root path.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Period</span>
        <span class="property-indicator"></span>
        <span class="property-type">int?</span>
    </dt>
    <dd>{{% md %}}How frequently the logs should be transferred in seconds. Default `3600`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Placement</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}Where in the generated VCL the logging call should be placed, overriding any `format_version` default. Can be either `none` or `waf_debug`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Response<wbr>Condition</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}The name of the `condition` to apply. If empty, always execute.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Secret<wbr>Key</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}The secret key associated with the sservice account that has write access to your BigQuery table. If not provided, this will be pulled from the `FASTLY_BQ_SECRET_KEY` environment variable. Typical format for this is a private key in a string with newlines.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Timestamp<wbr>Format</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}`strftime` specified timestamp formatting. Default `%Y-%m-%dT%H:%M:%S.000`.
{{% /md %}}</dd>

</dl>
{{% /choosable %}}


{{% choosable language go %}}
<dl class="resources-properties">

    <dt class="property-required"
            title="Required">
        <span>Bucket<wbr>Name</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}The name of the bucket in which to store the logs.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Email</span>
        <span class="property-indicator"></span>
        <span class="property-type">*string</span>
    </dt>
    <dd>{{% md %}}The email for the service account with write access to your BigQuery dataset. If not provided, this will be pulled from a `FASTLY_BQ_EMAIL` environment variable.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Format</span>
        <span class="property-indicator"></span>
        <span class="property-type">*string</span>
    </dt>
    <dd>{{% md %}}Apache-style string or VCL variables to use for log formatting. Default `%h %l %u %t \"%r\" %>s %b`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Gzip<wbr>Level</span>
        <span class="property-indicator"></span>
        <span class="property-type">*int</span>
    </dt>
    <dd>{{% md %}}Level of GZIP compression from `0`to `9`. `0` means no compression. `1` is the fastest and the least compressed version, `9` is the slowest and the most compressed version. Default `0`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Message<wbr>Type</span>
        <span class="property-indicator"></span>
        <span class="property-type">*string</span>
    </dt>
    <dd>{{% md %}}How the message should be formatted. Can be either `classic`, `loggly`, `logplex` or `blank`.  Default `classic`.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>Name</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}A unique name to identify this dictionary.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Path</span>
        <span class="property-indicator"></span>
        <span class="property-type">*string</span>
    </dt>
    <dd>{{% md %}}The path to upload logs to. Must end with a trailing slash. If this field is left empty, the files will be saved in the container's root path.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Period</span>
        <span class="property-indicator"></span>
        <span class="property-type">*int</span>
    </dt>
    <dd>{{% md %}}How frequently the logs should be transferred in seconds. Default `3600`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Placement</span>
        <span class="property-indicator"></span>
        <span class="property-type">*string</span>
    </dt>
    <dd>{{% md %}}Where in the generated VCL the logging call should be placed, overriding any `format_version` default. Can be either `none` or `waf_debug`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Response<wbr>Condition</span>
        <span class="property-indicator"></span>
        <span class="property-type">*string</span>
    </dt>
    <dd>{{% md %}}The name of the `condition` to apply. If empty, always execute.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Secret<wbr>Key</span>
        <span class="property-indicator"></span>
        <span class="property-type">*string</span>
    </dt>
    <dd>{{% md %}}The secret key associated with the sservice account that has write access to your BigQuery table. If not provided, this will be pulled from the `FASTLY_BQ_SECRET_KEY` environment variable. Typical format for this is a private key in a string with newlines.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Timestamp<wbr>Format</span>
        <span class="property-indicator"></span>
        <span class="property-type">*string</span>
    </dt>
    <dd>{{% md %}}`strftime` specified timestamp formatting. Default `%Y-%m-%dT%H:%M:%S.000`.
{{% /md %}}</dd>

</dl>
{{% /choosable %}}


{{% choosable language nodejs %}}
<dl class="resources-properties">

    <dt class="property-required"
            title="Required">
        <span>bucket<wbr>Name</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}The name of the bucket in which to store the logs.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>email</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}The email for the service account with write access to your BigQuery dataset. If not provided, this will be pulled from a `FASTLY_BQ_EMAIL` environment variable.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>format</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}Apache-style string or VCL variables to use for log formatting. Default `%h %l %u %t \"%r\" %>s %b`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>gzip<wbr>Level</span>
        <span class="property-indicator"></span>
        <span class="property-type">number?</span>
    </dt>
    <dd>{{% md %}}Level of GZIP compression from `0`to `9`. `0` means no compression. `1` is the fastest and the least compressed version, `9` is the slowest and the most compressed version. Default `0`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>message<wbr>Type</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}How the message should be formatted. Can be either `classic`, `loggly`, `logplex` or `blank`.  Default `classic`.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>name</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}A unique name to identify this dictionary.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>path</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}The path to upload logs to. Must end with a trailing slash. If this field is left empty, the files will be saved in the container's root path.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>period</span>
        <span class="property-indicator"></span>
        <span class="property-type">number?</span>
    </dt>
    <dd>{{% md %}}How frequently the logs should be transferred in seconds. Default `3600`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>placement</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}Where in the generated VCL the logging call should be placed, overriding any `format_version` default. Can be either `none` or `waf_debug`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>response<wbr>Condition</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}The name of the `condition` to apply. If empty, always execute.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>secret<wbr>Key</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}The secret key associated with the sservice account that has write access to your BigQuery table. If not provided, this will be pulled from the `FASTLY_BQ_SECRET_KEY` environment variable. Typical format for this is a private key in a string with newlines.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>timestamp<wbr>Format</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}`strftime` specified timestamp formatting. Default `%Y-%m-%dT%H:%M:%S.000`.
{{% /md %}}</dd>

</dl>
{{% /choosable %}}


{{% choosable language python %}}
<dl class="resources-properties">

    <dt class="property-required"
            title="Required">
        <span>bucket<wbr>Name</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}The name of the bucket in which to store the logs.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>email</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}The email for the service account with write access to your BigQuery dataset. If not provided, this will be pulled from a `FASTLY_BQ_EMAIL` environment variable.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>format</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}Apache-style string or VCL variables to use for log formatting. Default `%h %l %u %t \"%r\" %>s %b`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>gzip<wbr>Level</span>
        <span class="property-indicator"></span>
        <span class="property-type">float</span>
    </dt>
    <dd>{{% md %}}Level of GZIP compression from `0`to `9`. `0` means no compression. `1` is the fastest and the least compressed version, `9` is the slowest and the most compressed version. Default `0`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>message<wbr>Type</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}How the message should be formatted. Can be either `classic`, `loggly`, `logplex` or `blank`.  Default `classic`.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>name</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}A unique name to identify this dictionary.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>path</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}The path to upload logs to. Must end with a trailing slash. If this field is left empty, the files will be saved in the container's root path.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>period</span>
        <span class="property-indicator"></span>
        <span class="property-type">float</span>
    </dt>
    <dd>{{% md %}}How frequently the logs should be transferred in seconds. Default `3600`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>placement</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}Where in the generated VCL the logging call should be placed, overriding any `format_version` default. Can be either `none` or `waf_debug`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>response<wbr>Condition</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}The name of the `condition` to apply. If empty, always execute.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>secret<wbr>Key</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}The secret key associated with the sservice account that has write access to your BigQuery table. If not provided, this will be pulled from the `FASTLY_BQ_SECRET_KEY` environment variable. Typical format for this is a private key in a string with newlines.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>timestamp<wbr>Format</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}`strftime` specified timestamp formatting. Default `%Y-%m-%dT%H:%M:%S.000`.
{{% /md %}}</dd>

</dl>
{{% /choosable %}}





<h4>Servicev1Gzip</h4>
{{% choosable language nodejs %}}
> See the <a href="/docs/reference/pkg/nodejs/pulumi/fastly/types/input/#Servicev1Gzip">input</a> and <a href="/docs/reference/pkg/nodejs/pulumi/fastly/types/output/#Servicev1Gzip">output</a> API doc for this type.
{{% /choosable %}}

{{% choosable language go %}}
> See the <a href="https://pkg.go.dev/github.com/pulumi/pulumi-fastly/sdk/go/fastly/?tab=doc#Servicev1GzipArgs">input</a> and <a href="https://pkg.go.dev/github.com/pulumi/pulumi-fastly/sdk/go/fastly/?tab=doc#Servicev1GzipOutput">output</a> API doc for this type.
{{% /choosable %}}




{{% choosable language csharp %}}
<dl class="resources-properties">

    <dt class="property-optional"
            title="Optional">
        <span>Cache<wbr>Condition</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}Name of already defined `condition` to check after we have retrieved an object. If the condition passes then deliver this Request Object instead. This `condition` must be of type `CACHE`. For detailed information about Conditionals,
see [Fastly's Documentation on Conditionals][fastly-conditionals].
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Content<wbr>Types</span>
        <span class="property-indicator"></span>
        <span class="property-type">List<string>?</span>
    </dt>
    <dd>{{% md %}}The content-type for each type of content you wish to
have dynamically gzip'ed. Example: `["text/html", "text/css"]`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Extensions</span>
        <span class="property-indicator"></span>
        <span class="property-type">List<string>?</span>
    </dt>
    <dd>{{% md %}}File extensions for each file type to dynamically
gzip. Example: `["css", "js"]`.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>Name</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}A unique name to identify this dictionary.
{{% /md %}}</dd>

</dl>
{{% /choosable %}}


{{% choosable language go %}}
<dl class="resources-properties">

    <dt class="property-optional"
            title="Optional">
        <span>Cache<wbr>Condition</span>
        <span class="property-indicator"></span>
        <span class="property-type">*string</span>
    </dt>
    <dd>{{% md %}}Name of already defined `condition` to check after we have retrieved an object. If the condition passes then deliver this Request Object instead. This `condition` must be of type `CACHE`. For detailed information about Conditionals,
see [Fastly's Documentation on Conditionals][fastly-conditionals].
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Content<wbr>Types</span>
        <span class="property-indicator"></span>
        <span class="property-type">[]string</span>
    </dt>
    <dd>{{% md %}}The content-type for each type of content you wish to
have dynamically gzip'ed. Example: `["text/html", "text/css"]`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Extensions</span>
        <span class="property-indicator"></span>
        <span class="property-type">[]string</span>
    </dt>
    <dd>{{% md %}}File extensions for each file type to dynamically
gzip. Example: `["css", "js"]`.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>Name</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}A unique name to identify this dictionary.
{{% /md %}}</dd>

</dl>
{{% /choosable %}}


{{% choosable language nodejs %}}
<dl class="resources-properties">

    <dt class="property-optional"
            title="Optional">
        <span>cache<wbr>Condition</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}Name of already defined `condition` to check after we have retrieved an object. If the condition passes then deliver this Request Object instead. This `condition` must be of type `CACHE`. For detailed information about Conditionals,
see [Fastly's Documentation on Conditionals][fastly-conditionals].
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>content<wbr>Types</span>
        <span class="property-indicator"></span>
        <span class="property-type">string[]?</span>
    </dt>
    <dd>{{% md %}}The content-type for each type of content you wish to
have dynamically gzip'ed. Example: `["text/html", "text/css"]`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>extensions</span>
        <span class="property-indicator"></span>
        <span class="property-type">string[]?</span>
    </dt>
    <dd>{{% md %}}File extensions for each file type to dynamically
gzip. Example: `["css", "js"]`.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>name</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}A unique name to identify this dictionary.
{{% /md %}}</dd>

</dl>
{{% /choosable %}}


{{% choosable language python %}}
<dl class="resources-properties">

    <dt class="property-optional"
            title="Optional">
        <span>cache<wbr>Condition</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}Name of already defined `condition` to check after we have retrieved an object. If the condition passes then deliver this Request Object instead. This `condition` must be of type `CACHE`. For detailed information about Conditionals,
see [Fastly's Documentation on Conditionals][fastly-conditionals].
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>content<wbr>Types</span>
        <span class="property-indicator"></span>
        <span class="property-type">List[str]</span>
    </dt>
    <dd>{{% md %}}The content-type for each type of content you wish to
have dynamically gzip'ed. Example: `["text/html", "text/css"]`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>extensions</span>
        <span class="property-indicator"></span>
        <span class="property-type">List[str]</span>
    </dt>
    <dd>{{% md %}}File extensions for each file type to dynamically
gzip. Example: `["css", "js"]`.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>name</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}A unique name to identify this dictionary.
{{% /md %}}</dd>

</dl>
{{% /choosable %}}





<h4>Servicev1Header</h4>
{{% choosable language nodejs %}}
> See the <a href="/docs/reference/pkg/nodejs/pulumi/fastly/types/input/#Servicev1Header">input</a> and <a href="/docs/reference/pkg/nodejs/pulumi/fastly/types/output/#Servicev1Header">output</a> API doc for this type.
{{% /choosable %}}

{{% choosable language go %}}
> See the <a href="https://pkg.go.dev/github.com/pulumi/pulumi-fastly/sdk/go/fastly/?tab=doc#Servicev1HeaderArgs">input</a> and <a href="https://pkg.go.dev/github.com/pulumi/pulumi-fastly/sdk/go/fastly/?tab=doc#Servicev1HeaderOutput">output</a> API doc for this type.
{{% /choosable %}}




{{% choosable language csharp %}}
<dl class="resources-properties">

    <dt class="property-required"
            title="Required">
        <span>Action</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}Allows you to terminate request handling and immediately
perform an action. When set it can be `lookup` or `pass` (Ignore the cache completely).
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Cache<wbr>Condition</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}Name of already defined `condition` to check after we have retrieved an object. If the condition passes then deliver this Request Object instead. This `condition` must be of type `CACHE`. For detailed information about Conditionals,
see [Fastly's Documentation on Conditionals][fastly-conditionals].
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>Destination</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}The name of the header that is going to be affected by the Action.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Ignore<wbr>If<wbr>Set</span>
        <span class="property-indicator"></span>
        <span class="property-type">bool?</span>
    </dt>
    <dd>{{% md %}}Do not add the header if it is already present. (Only applies to the `set` action.). Default `false`.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>Name</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}A unique name to identify this dictionary.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Priority</span>
        <span class="property-indicator"></span>
        <span class="property-type">int?</span>
    </dt>
    <dd>{{% md %}}Priority determines the ordering for multiple snippets. Lower numbers execute first.  Defaults to `100`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Regex</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}Regular expression to use (Only applies to the `regex` and `regex_repeat` actions.)
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Request<wbr>Condition</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}Name of already defined `condition` to be checked during the request phase. If the condition passes then this object will be delivered. This `condition` must be of type `REQUEST`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Response<wbr>Condition</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}The name of the `condition` to apply. If empty, always execute.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Source</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}Variable to be used as a source for the header
content. (Does not apply to the `delete` action.)
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Substitution</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}Value to substitute in place of regular expression. (Only applies to the `regex` and `regex_repeat` actions.)
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>Type</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}The location in generated VCL where the snippet should be placed (can be one of `init`, `recv`, `hit`, `miss`, `pass`, `fetch`, `error`, `deliver`, `log` or `none`).
{{% /md %}}</dd>

</dl>
{{% /choosable %}}


{{% choosable language go %}}
<dl class="resources-properties">

    <dt class="property-required"
            title="Required">
        <span>Action</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}Allows you to terminate request handling and immediately
perform an action. When set it can be `lookup` or `pass` (Ignore the cache completely).
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Cache<wbr>Condition</span>
        <span class="property-indicator"></span>
        <span class="property-type">*string</span>
    </dt>
    <dd>{{% md %}}Name of already defined `condition` to check after we have retrieved an object. If the condition passes then deliver this Request Object instead. This `condition` must be of type `CACHE`. For detailed information about Conditionals,
see [Fastly's Documentation on Conditionals][fastly-conditionals].
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>Destination</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}The name of the header that is going to be affected by the Action.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Ignore<wbr>If<wbr>Set</span>
        <span class="property-indicator"></span>
        <span class="property-type">*bool</span>
    </dt>
    <dd>{{% md %}}Do not add the header if it is already present. (Only applies to the `set` action.). Default `false`.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>Name</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}A unique name to identify this dictionary.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Priority</span>
        <span class="property-indicator"></span>
        <span class="property-type">*int</span>
    </dt>
    <dd>{{% md %}}Priority determines the ordering for multiple snippets. Lower numbers execute first.  Defaults to `100`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Regex</span>
        <span class="property-indicator"></span>
        <span class="property-type">*string</span>
    </dt>
    <dd>{{% md %}}Regular expression to use (Only applies to the `regex` and `regex_repeat` actions.)
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Request<wbr>Condition</span>
        <span class="property-indicator"></span>
        <span class="property-type">*string</span>
    </dt>
    <dd>{{% md %}}Name of already defined `condition` to be checked during the request phase. If the condition passes then this object will be delivered. This `condition` must be of type `REQUEST`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Response<wbr>Condition</span>
        <span class="property-indicator"></span>
        <span class="property-type">*string</span>
    </dt>
    <dd>{{% md %}}The name of the `condition` to apply. If empty, always execute.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Source</span>
        <span class="property-indicator"></span>
        <span class="property-type">*string</span>
    </dt>
    <dd>{{% md %}}Variable to be used as a source for the header
content. (Does not apply to the `delete` action.)
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Substitution</span>
        <span class="property-indicator"></span>
        <span class="property-type">*string</span>
    </dt>
    <dd>{{% md %}}Value to substitute in place of regular expression. (Only applies to the `regex` and `regex_repeat` actions.)
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>Type</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}The location in generated VCL where the snippet should be placed (can be one of `init`, `recv`, `hit`, `miss`, `pass`, `fetch`, `error`, `deliver`, `log` or `none`).
{{% /md %}}</dd>

</dl>
{{% /choosable %}}


{{% choosable language nodejs %}}
<dl class="resources-properties">

    <dt class="property-required"
            title="Required">
        <span>action</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}Allows you to terminate request handling and immediately
perform an action. When set it can be `lookup` or `pass` (Ignore the cache completely).
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>cache<wbr>Condition</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}Name of already defined `condition` to check after we have retrieved an object. If the condition passes then deliver this Request Object instead. This `condition` must be of type `CACHE`. For detailed information about Conditionals,
see [Fastly's Documentation on Conditionals][fastly-conditionals].
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>destination</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}The name of the header that is going to be affected by the Action.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>ignore<wbr>If<wbr>Set</span>
        <span class="property-indicator"></span>
        <span class="property-type">boolean?</span>
    </dt>
    <dd>{{% md %}}Do not add the header if it is already present. (Only applies to the `set` action.). Default `false`.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>name</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}A unique name to identify this dictionary.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>priority</span>
        <span class="property-indicator"></span>
        <span class="property-type">number?</span>
    </dt>
    <dd>{{% md %}}Priority determines the ordering for multiple snippets. Lower numbers execute first.  Defaults to `100`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>regex</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}Regular expression to use (Only applies to the `regex` and `regex_repeat` actions.)
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>request<wbr>Condition</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}Name of already defined `condition` to be checked during the request phase. If the condition passes then this object will be delivered. This `condition` must be of type `REQUEST`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>response<wbr>Condition</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}The name of the `condition` to apply. If empty, always execute.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>source</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}Variable to be used as a source for the header
content. (Does not apply to the `delete` action.)
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>substitution</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}Value to substitute in place of regular expression. (Only applies to the `regex` and `regex_repeat` actions.)
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>type</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}The location in generated VCL where the snippet should be placed (can be one of `init`, `recv`, `hit`, `miss`, `pass`, `fetch`, `error`, `deliver`, `log` or `none`).
{{% /md %}}</dd>

</dl>
{{% /choosable %}}


{{% choosable language python %}}
<dl class="resources-properties">

    <dt class="property-required"
            title="Required">
        <span>action</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}Allows you to terminate request handling and immediately
perform an action. When set it can be `lookup` or `pass` (Ignore the cache completely).
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>cache<wbr>Condition</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}Name of already defined `condition` to check after we have retrieved an object. If the condition passes then deliver this Request Object instead. This `condition` must be of type `CACHE`. For detailed information about Conditionals,
see [Fastly's Documentation on Conditionals][fastly-conditionals].
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>destination</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}The name of the header that is going to be affected by the Action.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>ignore<wbr>If<wbr>Set</span>
        <span class="property-indicator"></span>
        <span class="property-type">bool</span>
    </dt>
    <dd>{{% md %}}Do not add the header if it is already present. (Only applies to the `set` action.). Default `false`.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>name</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}A unique name to identify this dictionary.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>priority</span>
        <span class="property-indicator"></span>
        <span class="property-type">float</span>
    </dt>
    <dd>{{% md %}}Priority determines the ordering for multiple snippets. Lower numbers execute first.  Defaults to `100`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>regex</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}Regular expression to use (Only applies to the `regex` and `regex_repeat` actions.)
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>request<wbr>Condition</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}Name of already defined `condition` to be checked during the request phase. If the condition passes then this object will be delivered. This `condition` must be of type `REQUEST`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>response<wbr>Condition</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}The name of the `condition` to apply. If empty, always execute.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>source</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}Variable to be used as a source for the header
content. (Does not apply to the `delete` action.)
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>substitution</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}Value to substitute in place of regular expression. (Only applies to the `regex` and `regex_repeat` actions.)
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>type</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}The location in generated VCL where the snippet should be placed (can be one of `init`, `recv`, `hit`, `miss`, `pass`, `fetch`, `error`, `deliver`, `log` or `none`).
{{% /md %}}</dd>

</dl>
{{% /choosable %}}





<h4>Servicev1Healthcheck</h4>
{{% choosable language nodejs %}}
> See the <a href="/docs/reference/pkg/nodejs/pulumi/fastly/types/input/#Servicev1Healthcheck">input</a> and <a href="/docs/reference/pkg/nodejs/pulumi/fastly/types/output/#Servicev1Healthcheck">output</a> API doc for this type.
{{% /choosable %}}

{{% choosable language go %}}
> See the <a href="https://pkg.go.dev/github.com/pulumi/pulumi-fastly/sdk/go/fastly/?tab=doc#Servicev1HealthcheckArgs">input</a> and <a href="https://pkg.go.dev/github.com/pulumi/pulumi-fastly/sdk/go/fastly/?tab=doc#Servicev1HealthcheckOutput">output</a> API doc for this type.
{{% /choosable %}}




{{% choosable language csharp %}}
<dl class="resources-properties">

    <dt class="property-optional"
            title="Optional">
        <span>Check<wbr>Interval</span>
        <span class="property-indicator"></span>
        <span class="property-type">int?</span>
    </dt>
    <dd>{{% md %}}How often to run the Healthcheck in milliseconds. Default `5000`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Expected<wbr>Response</span>
        <span class="property-indicator"></span>
        <span class="property-type">int?</span>
    </dt>
    <dd>{{% md %}}The status code expected from the host. Default `200`.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>Host</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}The Host header to send for this Healthcheck.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Http<wbr>Version</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}Whether to use version 1.0 or 1.1 HTTP. Default `1.1`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Initial</span>
        <span class="property-indicator"></span>
        <span class="property-type">int?</span>
    </dt>
    <dd>{{% md %}}When loading a config, the initial number of probes to be seen as OK. Default `2`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Method</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}Which HTTP method to use. Default `HEAD`.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>Name</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}A unique name to identify this dictionary.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>Path</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}The path to upload logs to. Must end with a trailing slash. If this field is left empty, the files will be saved in the container's root path.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Threshold</span>
        <span class="property-indicator"></span>
        <span class="property-type">int?</span>
    </dt>
    <dd>{{% md %}}How many Healthchecks must succeed to be considered healthy. Default `3`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Timeout</span>
        <span class="property-indicator"></span>
        <span class="property-type">int?</span>
    </dt>
    <dd>{{% md %}}Timeout in milliseconds. Default `500`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Window</span>
        <span class="property-indicator"></span>
        <span class="property-type">int?</span>
    </dt>
    <dd>{{% md %}}The number of most recent Healthcheck queries to keep for this Healthcheck. Default `5`.
{{% /md %}}</dd>

</dl>
{{% /choosable %}}


{{% choosable language go %}}
<dl class="resources-properties">

    <dt class="property-optional"
            title="Optional">
        <span>Check<wbr>Interval</span>
        <span class="property-indicator"></span>
        <span class="property-type">*int</span>
    </dt>
    <dd>{{% md %}}How often to run the Healthcheck in milliseconds. Default `5000`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Expected<wbr>Response</span>
        <span class="property-indicator"></span>
        <span class="property-type">*int</span>
    </dt>
    <dd>{{% md %}}The status code expected from the host. Default `200`.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>Host</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}The Host header to send for this Healthcheck.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Http<wbr>Version</span>
        <span class="property-indicator"></span>
        <span class="property-type">*string</span>
    </dt>
    <dd>{{% md %}}Whether to use version 1.0 or 1.1 HTTP. Default `1.1`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Initial</span>
        <span class="property-indicator"></span>
        <span class="property-type">*int</span>
    </dt>
    <dd>{{% md %}}When loading a config, the initial number of probes to be seen as OK. Default `2`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Method</span>
        <span class="property-indicator"></span>
        <span class="property-type">*string</span>
    </dt>
    <dd>{{% md %}}Which HTTP method to use. Default `HEAD`.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>Name</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}A unique name to identify this dictionary.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>Path</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}The path to upload logs to. Must end with a trailing slash. If this field is left empty, the files will be saved in the container's root path.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Threshold</span>
        <span class="property-indicator"></span>
        <span class="property-type">*int</span>
    </dt>
    <dd>{{% md %}}How many Healthchecks must succeed to be considered healthy. Default `3`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Timeout</span>
        <span class="property-indicator"></span>
        <span class="property-type">*int</span>
    </dt>
    <dd>{{% md %}}Timeout in milliseconds. Default `500`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Window</span>
        <span class="property-indicator"></span>
        <span class="property-type">*int</span>
    </dt>
    <dd>{{% md %}}The number of most recent Healthcheck queries to keep for this Healthcheck. Default `5`.
{{% /md %}}</dd>

</dl>
{{% /choosable %}}


{{% choosable language nodejs %}}
<dl class="resources-properties">

    <dt class="property-optional"
            title="Optional">
        <span>check<wbr>Interval</span>
        <span class="property-indicator"></span>
        <span class="property-type">number?</span>
    </dt>
    <dd>{{% md %}}How often to run the Healthcheck in milliseconds. Default `5000`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>expected<wbr>Response</span>
        <span class="property-indicator"></span>
        <span class="property-type">number?</span>
    </dt>
    <dd>{{% md %}}The status code expected from the host. Default `200`.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>host</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}The Host header to send for this Healthcheck.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>http<wbr>Version</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}Whether to use version 1.0 or 1.1 HTTP. Default `1.1`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>initial</span>
        <span class="property-indicator"></span>
        <span class="property-type">number?</span>
    </dt>
    <dd>{{% md %}}When loading a config, the initial number of probes to be seen as OK. Default `2`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>method</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}Which HTTP method to use. Default `HEAD`.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>name</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}A unique name to identify this dictionary.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>path</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}The path to upload logs to. Must end with a trailing slash. If this field is left empty, the files will be saved in the container's root path.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>threshold</span>
        <span class="property-indicator"></span>
        <span class="property-type">number?</span>
    </dt>
    <dd>{{% md %}}How many Healthchecks must succeed to be considered healthy. Default `3`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>timeout</span>
        <span class="property-indicator"></span>
        <span class="property-type">number?</span>
    </dt>
    <dd>{{% md %}}Timeout in milliseconds. Default `500`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>window</span>
        <span class="property-indicator"></span>
        <span class="property-type">number?</span>
    </dt>
    <dd>{{% md %}}The number of most recent Healthcheck queries to keep for this Healthcheck. Default `5`.
{{% /md %}}</dd>

</dl>
{{% /choosable %}}


{{% choosable language python %}}
<dl class="resources-properties">

    <dt class="property-optional"
            title="Optional">
        <span>check<wbr>Interval</span>
        <span class="property-indicator"></span>
        <span class="property-type">float</span>
    </dt>
    <dd>{{% md %}}How often to run the Healthcheck in milliseconds. Default `5000`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>expected<wbr>Response</span>
        <span class="property-indicator"></span>
        <span class="property-type">float</span>
    </dt>
    <dd>{{% md %}}The status code expected from the host. Default `200`.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>host</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}The Host header to send for this Healthcheck.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>http<wbr>Version</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}Whether to use version 1.0 or 1.1 HTTP. Default `1.1`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>initial</span>
        <span class="property-indicator"></span>
        <span class="property-type">float</span>
    </dt>
    <dd>{{% md %}}When loading a config, the initial number of probes to be seen as OK. Default `2`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>method</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}Which HTTP method to use. Default `HEAD`.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>name</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}A unique name to identify this dictionary.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>path</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}The path to upload logs to. Must end with a trailing slash. If this field is left empty, the files will be saved in the container's root path.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>threshold</span>
        <span class="property-indicator"></span>
        <span class="property-type">float</span>
    </dt>
    <dd>{{% md %}}How many Healthchecks must succeed to be considered healthy. Default `3`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>timeout</span>
        <span class="property-indicator"></span>
        <span class="property-type">float</span>
    </dt>
    <dd>{{% md %}}Timeout in milliseconds. Default `500`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>window</span>
        <span class="property-indicator"></span>
        <span class="property-type">float</span>
    </dt>
    <dd>{{% md %}}The number of most recent Healthcheck queries to keep for this Healthcheck. Default `5`.
{{% /md %}}</dd>

</dl>
{{% /choosable %}}





<h4>Servicev1Logentry</h4>
{{% choosable language nodejs %}}
> See the <a href="/docs/reference/pkg/nodejs/pulumi/fastly/types/input/#Servicev1Logentry">input</a> and <a href="/docs/reference/pkg/nodejs/pulumi/fastly/types/output/#Servicev1Logentry">output</a> API doc for this type.
{{% /choosable %}}

{{% choosable language go %}}
> See the <a href="https://pkg.go.dev/github.com/pulumi/pulumi-fastly/sdk/go/fastly/?tab=doc#Servicev1LogentryArgs">input</a> and <a href="https://pkg.go.dev/github.com/pulumi/pulumi-fastly/sdk/go/fastly/?tab=doc#Servicev1LogentryOutput">output</a> API doc for this type.
{{% /choosable %}}




{{% choosable language csharp %}}
<dl class="resources-properties">

    <dt class="property-optional"
            title="Optional">
        <span>Format</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}Apache-style string or VCL variables to use for log formatting. Default `%h %l %u %t \"%r\" %>s %b`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Format<wbr>Version</span>
        <span class="property-indicator"></span>
        <span class="property-type">int?</span>
    </dt>
    <dd>{{% md %}}The version of the custom logging format used for the configured endpoint. Can be either `1` or `2`. The logging call gets placed by default in `vcl_log` if `format_version` is set to `2` and in `vcl_deliver` if `format_version` is set to `1`. Default `2`.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>Name</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}A unique name to identify this dictionary.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Placement</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}Where in the generated VCL the logging call should be placed, overriding any `format_version` default. Can be either `none` or `waf_debug`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Port</span>
        <span class="property-indicator"></span>
        <span class="property-type">int?</span>
    </dt>
    <dd>{{% md %}}The port number configured in Logentries to send logs to. Defaults to `20000`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Response<wbr>Condition</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}The name of the `condition` to apply. If empty, always execute.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>Token</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}The Splunk token to be used for authentication.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Use<wbr>Tls</span>
        <span class="property-indicator"></span>
        <span class="property-type">bool?</span>
    </dt>
    <dd>{{% md %}}Whether to use TLS for secure logging. Defaults to `true`
{{% /md %}}</dd>

</dl>
{{% /choosable %}}


{{% choosable language go %}}
<dl class="resources-properties">

    <dt class="property-optional"
            title="Optional">
        <span>Format</span>
        <span class="property-indicator"></span>
        <span class="property-type">*string</span>
    </dt>
    <dd>{{% md %}}Apache-style string or VCL variables to use for log formatting. Default `%h %l %u %t \"%r\" %>s %b`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Format<wbr>Version</span>
        <span class="property-indicator"></span>
        <span class="property-type">*int</span>
    </dt>
    <dd>{{% md %}}The version of the custom logging format used for the configured endpoint. Can be either `1` or `2`. The logging call gets placed by default in `vcl_log` if `format_version` is set to `2` and in `vcl_deliver` if `format_version` is set to `1`. Default `2`.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>Name</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}A unique name to identify this dictionary.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Placement</span>
        <span class="property-indicator"></span>
        <span class="property-type">*string</span>
    </dt>
    <dd>{{% md %}}Where in the generated VCL the logging call should be placed, overriding any `format_version` default. Can be either `none` or `waf_debug`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Port</span>
        <span class="property-indicator"></span>
        <span class="property-type">*int</span>
    </dt>
    <dd>{{% md %}}The port number configured in Logentries to send logs to. Defaults to `20000`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Response<wbr>Condition</span>
        <span class="property-indicator"></span>
        <span class="property-type">*string</span>
    </dt>
    <dd>{{% md %}}The name of the `condition` to apply. If empty, always execute.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>Token</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}The Splunk token to be used for authentication.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Use<wbr>Tls</span>
        <span class="property-indicator"></span>
        <span class="property-type">*bool</span>
    </dt>
    <dd>{{% md %}}Whether to use TLS for secure logging. Defaults to `true`
{{% /md %}}</dd>

</dl>
{{% /choosable %}}


{{% choosable language nodejs %}}
<dl class="resources-properties">

    <dt class="property-optional"
            title="Optional">
        <span>format</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}Apache-style string or VCL variables to use for log formatting. Default `%h %l %u %t \"%r\" %>s %b`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>format<wbr>Version</span>
        <span class="property-indicator"></span>
        <span class="property-type">number?</span>
    </dt>
    <dd>{{% md %}}The version of the custom logging format used for the configured endpoint. Can be either `1` or `2`. The logging call gets placed by default in `vcl_log` if `format_version` is set to `2` and in `vcl_deliver` if `format_version` is set to `1`. Default `2`.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>name</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}A unique name to identify this dictionary.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>placement</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}Where in the generated VCL the logging call should be placed, overriding any `format_version` default. Can be either `none` or `waf_debug`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>port</span>
        <span class="property-indicator"></span>
        <span class="property-type">number?</span>
    </dt>
    <dd>{{% md %}}The port number configured in Logentries to send logs to. Defaults to `20000`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>response<wbr>Condition</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}The name of the `condition` to apply. If empty, always execute.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>token</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}The Splunk token to be used for authentication.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>use<wbr>Tls</span>
        <span class="property-indicator"></span>
        <span class="property-type">boolean?</span>
    </dt>
    <dd>{{% md %}}Whether to use TLS for secure logging. Defaults to `true`
{{% /md %}}</dd>

</dl>
{{% /choosable %}}


{{% choosable language python %}}
<dl class="resources-properties">

    <dt class="property-optional"
            title="Optional">
        <span>format</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}Apache-style string or VCL variables to use for log formatting. Default `%h %l %u %t \"%r\" %>s %b`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>format<wbr>Version</span>
        <span class="property-indicator"></span>
        <span class="property-type">float</span>
    </dt>
    <dd>{{% md %}}The version of the custom logging format used for the configured endpoint. Can be either `1` or `2`. The logging call gets placed by default in `vcl_log` if `format_version` is set to `2` and in `vcl_deliver` if `format_version` is set to `1`. Default `2`.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>name</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}A unique name to identify this dictionary.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>placement</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}Where in the generated VCL the logging call should be placed, overriding any `format_version` default. Can be either `none` or `waf_debug`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>port</span>
        <span class="property-indicator"></span>
        <span class="property-type">float</span>
    </dt>
    <dd>{{% md %}}The port number configured in Logentries to send logs to. Defaults to `20000`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>response<wbr>Condition</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}The name of the `condition` to apply. If empty, always execute.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>token</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}The Splunk token to be used for authentication.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>use<wbr>Tls</span>
        <span class="property-indicator"></span>
        <span class="property-type">bool</span>
    </dt>
    <dd>{{% md %}}Whether to use TLS for secure logging. Defaults to `true`
{{% /md %}}</dd>

</dl>
{{% /choosable %}}





<h4>Servicev1Papertrail</h4>
{{% choosable language nodejs %}}
> See the <a href="/docs/reference/pkg/nodejs/pulumi/fastly/types/input/#Servicev1Papertrail">input</a> and <a href="/docs/reference/pkg/nodejs/pulumi/fastly/types/output/#Servicev1Papertrail">output</a> API doc for this type.
{{% /choosable %}}

{{% choosable language go %}}
> See the <a href="https://pkg.go.dev/github.com/pulumi/pulumi-fastly/sdk/go/fastly/?tab=doc#Servicev1PapertrailArgs">input</a> and <a href="https://pkg.go.dev/github.com/pulumi/pulumi-fastly/sdk/go/fastly/?tab=doc#Servicev1PapertrailOutput">output</a> API doc for this type.
{{% /choosable %}}




{{% choosable language csharp %}}
<dl class="resources-properties">

    <dt class="property-required"
            title="Required">
        <span>Address</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}A hostname or IPv4 address of the Syslog endpoint.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Format</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}Apache-style string or VCL variables to use for log formatting. Default `%h %l %u %t \"%r\" %>s %b`.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>Name</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}A unique name to identify this dictionary.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Placement</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}Where in the generated VCL the logging call should be placed, overriding any `format_version` default. Can be either `none` or `waf_debug`.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>Port</span>
        <span class="property-indicator"></span>
        <span class="property-type">int</span>
    </dt>
    <dd>{{% md %}}The port number configured in Logentries to send logs to. Defaults to `20000`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Response<wbr>Condition</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}The name of the `condition` to apply. If empty, always execute.
{{% /md %}}</dd>

</dl>
{{% /choosable %}}


{{% choosable language go %}}
<dl class="resources-properties">

    <dt class="property-required"
            title="Required">
        <span>Address</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}A hostname or IPv4 address of the Syslog endpoint.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Format</span>
        <span class="property-indicator"></span>
        <span class="property-type">*string</span>
    </dt>
    <dd>{{% md %}}Apache-style string or VCL variables to use for log formatting. Default `%h %l %u %t \"%r\" %>s %b`.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>Name</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}A unique name to identify this dictionary.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Placement</span>
        <span class="property-indicator"></span>
        <span class="property-type">*string</span>
    </dt>
    <dd>{{% md %}}Where in the generated VCL the logging call should be placed, overriding any `format_version` default. Can be either `none` or `waf_debug`.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>Port</span>
        <span class="property-indicator"></span>
        <span class="property-type">int</span>
    </dt>
    <dd>{{% md %}}The port number configured in Logentries to send logs to. Defaults to `20000`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Response<wbr>Condition</span>
        <span class="property-indicator"></span>
        <span class="property-type">*string</span>
    </dt>
    <dd>{{% md %}}The name of the `condition` to apply. If empty, always execute.
{{% /md %}}</dd>

</dl>
{{% /choosable %}}


{{% choosable language nodejs %}}
<dl class="resources-properties">

    <dt class="property-required"
            title="Required">
        <span>address</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}A hostname or IPv4 address of the Syslog endpoint.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>format</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}Apache-style string or VCL variables to use for log formatting. Default `%h %l %u %t \"%r\" %>s %b`.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>name</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}A unique name to identify this dictionary.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>placement</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}Where in the generated VCL the logging call should be placed, overriding any `format_version` default. Can be either `none` or `waf_debug`.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>port</span>
        <span class="property-indicator"></span>
        <span class="property-type">number</span>
    </dt>
    <dd>{{% md %}}The port number configured in Logentries to send logs to. Defaults to `20000`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>response<wbr>Condition</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}The name of the `condition` to apply. If empty, always execute.
{{% /md %}}</dd>

</dl>
{{% /choosable %}}


{{% choosable language python %}}
<dl class="resources-properties">

    <dt class="property-required"
            title="Required">
        <span>address</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}A hostname or IPv4 address of the Syslog endpoint.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>format</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}Apache-style string or VCL variables to use for log formatting. Default `%h %l %u %t \"%r\" %>s %b`.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>name</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}A unique name to identify this dictionary.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>placement</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}Where in the generated VCL the logging call should be placed, overriding any `format_version` default. Can be either `none` or `waf_debug`.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>port</span>
        <span class="property-indicator"></span>
        <span class="property-type">float</span>
    </dt>
    <dd>{{% md %}}The port number configured in Logentries to send logs to. Defaults to `20000`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>response<wbr>Condition</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}The name of the `condition` to apply. If empty, always execute.
{{% /md %}}</dd>

</dl>
{{% /choosable %}}





<h4>Servicev1Request<wbr>Setting</h4>
{{% choosable language nodejs %}}
> See the <a href="/docs/reference/pkg/nodejs/pulumi/fastly/types/input/#Servicev1RequestSetting">input</a> and <a href="/docs/reference/pkg/nodejs/pulumi/fastly/types/output/#Servicev1RequestSetting">output</a> API doc for this type.
{{% /choosable %}}

{{% choosable language go %}}
> See the <a href="https://pkg.go.dev/github.com/pulumi/pulumi-fastly/sdk/go/fastly/?tab=doc#Servicev1RequestSettingArgs">input</a> and <a href="https://pkg.go.dev/github.com/pulumi/pulumi-fastly/sdk/go/fastly/?tab=doc#Servicev1RequestSettingOutput">output</a> API doc for this type.
{{% /choosable %}}




{{% choosable language csharp %}}
<dl class="resources-properties">

    <dt class="property-optional"
            title="Optional">
        <span>Action</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}Allows you to terminate request handling and immediately
perform an action. When set it can be `lookup` or `pass` (Ignore the cache completely).
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Bypass<wbr>Busy<wbr>Wait</span>
        <span class="property-indicator"></span>
        <span class="property-type">bool?</span>
    </dt>
    <dd>{{% md %}}Disable collapsed forwarding, so you don't wait
for other objects to origin.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Default<wbr>Host</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}Sets the host header.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Force<wbr>Miss</span>
        <span class="property-indicator"></span>
        <span class="property-type">bool?</span>
    </dt>
    <dd>{{% md %}}Force a cache miss for the request. If specified,
can be `true` or `false`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Force<wbr>Ssl</span>
        <span class="property-indicator"></span>
        <span class="property-type">bool?</span>
    </dt>
    <dd>{{% md %}}Forces the request to use SSL (Redirects a non-SSL request to SSL).
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Geo<wbr>Headers</span>
        <span class="property-indicator"></span>
        <span class="property-type">bool?</span>
    </dt>
    <dd>{{% md %}}Injects Fastly-Geo-Country, Fastly-Geo-City, and
Fastly-Geo-Region into the request headers.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Hash<wbr>Keys</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}Comma separated list of varnish request object fields
that should be in the hash key.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Max<wbr>Stale<wbr>Age</span>
        <span class="property-indicator"></span>
        <span class="property-type">int?</span>
    </dt>
    <dd>{{% md %}}How old an object is allowed to be to serve
`stale-if-error` or `stale-while-revalidate`, in seconds.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>Name</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}A unique name to identify this dictionary.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Request<wbr>Condition</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}Name of already defined `condition` to be checked during the request phase. If the condition passes then this object will be delivered. This `condition` must be of type `REQUEST`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Timer<wbr>Support</span>
        <span class="property-indicator"></span>
        <span class="property-type">bool?</span>
    </dt>
    <dd>{{% md %}}Injects the X-Timer info into the request for
viewing origin fetch durations.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Xff</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}X-Forwarded-For, should be `clear`, `leave`, `append`,
`append_all`, or `overwrite`. Default `append`.
{{% /md %}}</dd>

</dl>
{{% /choosable %}}


{{% choosable language go %}}
<dl class="resources-properties">

    <dt class="property-optional"
            title="Optional">
        <span>Action</span>
        <span class="property-indicator"></span>
        <span class="property-type">*string</span>
    </dt>
    <dd>{{% md %}}Allows you to terminate request handling and immediately
perform an action. When set it can be `lookup` or `pass` (Ignore the cache completely).
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Bypass<wbr>Busy<wbr>Wait</span>
        <span class="property-indicator"></span>
        <span class="property-type">*bool</span>
    </dt>
    <dd>{{% md %}}Disable collapsed forwarding, so you don't wait
for other objects to origin.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Default<wbr>Host</span>
        <span class="property-indicator"></span>
        <span class="property-type">*string</span>
    </dt>
    <dd>{{% md %}}Sets the host header.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Force<wbr>Miss</span>
        <span class="property-indicator"></span>
        <span class="property-type">*bool</span>
    </dt>
    <dd>{{% md %}}Force a cache miss for the request. If specified,
can be `true` or `false`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Force<wbr>Ssl</span>
        <span class="property-indicator"></span>
        <span class="property-type">*bool</span>
    </dt>
    <dd>{{% md %}}Forces the request to use SSL (Redirects a non-SSL request to SSL).
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Geo<wbr>Headers</span>
        <span class="property-indicator"></span>
        <span class="property-type">*bool</span>
    </dt>
    <dd>{{% md %}}Injects Fastly-Geo-Country, Fastly-Geo-City, and
Fastly-Geo-Region into the request headers.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Hash<wbr>Keys</span>
        <span class="property-indicator"></span>
        <span class="property-type">*string</span>
    </dt>
    <dd>{{% md %}}Comma separated list of varnish request object fields
that should be in the hash key.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Max<wbr>Stale<wbr>Age</span>
        <span class="property-indicator"></span>
        <span class="property-type">*int</span>
    </dt>
    <dd>{{% md %}}How old an object is allowed to be to serve
`stale-if-error` or `stale-while-revalidate`, in seconds.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>Name</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}A unique name to identify this dictionary.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Request<wbr>Condition</span>
        <span class="property-indicator"></span>
        <span class="property-type">*string</span>
    </dt>
    <dd>{{% md %}}Name of already defined `condition` to be checked during the request phase. If the condition passes then this object will be delivered. This `condition` must be of type `REQUEST`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Timer<wbr>Support</span>
        <span class="property-indicator"></span>
        <span class="property-type">*bool</span>
    </dt>
    <dd>{{% md %}}Injects the X-Timer info into the request for
viewing origin fetch durations.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Xff</span>
        <span class="property-indicator"></span>
        <span class="property-type">*string</span>
    </dt>
    <dd>{{% md %}}X-Forwarded-For, should be `clear`, `leave`, `append`,
`append_all`, or `overwrite`. Default `append`.
{{% /md %}}</dd>

</dl>
{{% /choosable %}}


{{% choosable language nodejs %}}
<dl class="resources-properties">

    <dt class="property-optional"
            title="Optional">
        <span>action</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}Allows you to terminate request handling and immediately
perform an action. When set it can be `lookup` or `pass` (Ignore the cache completely).
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>bypass<wbr>Busy<wbr>Wait</span>
        <span class="property-indicator"></span>
        <span class="property-type">boolean?</span>
    </dt>
    <dd>{{% md %}}Disable collapsed forwarding, so you don't wait
for other objects to origin.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>default<wbr>Host</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}Sets the host header.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>force<wbr>Miss</span>
        <span class="property-indicator"></span>
        <span class="property-type">boolean?</span>
    </dt>
    <dd>{{% md %}}Force a cache miss for the request. If specified,
can be `true` or `false`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>force<wbr>Ssl</span>
        <span class="property-indicator"></span>
        <span class="property-type">boolean?</span>
    </dt>
    <dd>{{% md %}}Forces the request to use SSL (Redirects a non-SSL request to SSL).
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>geo<wbr>Headers</span>
        <span class="property-indicator"></span>
        <span class="property-type">boolean?</span>
    </dt>
    <dd>{{% md %}}Injects Fastly-Geo-Country, Fastly-Geo-City, and
Fastly-Geo-Region into the request headers.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>hash<wbr>Keys</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}Comma separated list of varnish request object fields
that should be in the hash key.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>max<wbr>Stale<wbr>Age</span>
        <span class="property-indicator"></span>
        <span class="property-type">number?</span>
    </dt>
    <dd>{{% md %}}How old an object is allowed to be to serve
`stale-if-error` or `stale-while-revalidate`, in seconds.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>name</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}A unique name to identify this dictionary.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>request<wbr>Condition</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}Name of already defined `condition` to be checked during the request phase. If the condition passes then this object will be delivered. This `condition` must be of type `REQUEST`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>timer<wbr>Support</span>
        <span class="property-indicator"></span>
        <span class="property-type">boolean?</span>
    </dt>
    <dd>{{% md %}}Injects the X-Timer info into the request for
viewing origin fetch durations.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>xff</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}X-Forwarded-For, should be `clear`, `leave`, `append`,
`append_all`, or `overwrite`. Default `append`.
{{% /md %}}</dd>

</dl>
{{% /choosable %}}


{{% choosable language python %}}
<dl class="resources-properties">

    <dt class="property-optional"
            title="Optional">
        <span>action</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}Allows you to terminate request handling and immediately
perform an action. When set it can be `lookup` or `pass` (Ignore the cache completely).
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>bypass<wbr>Busy<wbr>Wait</span>
        <span class="property-indicator"></span>
        <span class="property-type">bool</span>
    </dt>
    <dd>{{% md %}}Disable collapsed forwarding, so you don't wait
for other objects to origin.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>default_<wbr>host</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}Sets the host header.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>force<wbr>Miss</span>
        <span class="property-indicator"></span>
        <span class="property-type">bool</span>
    </dt>
    <dd>{{% md %}}Force a cache miss for the request. If specified,
can be `true` or `false`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>force<wbr>Ssl</span>
        <span class="property-indicator"></span>
        <span class="property-type">bool</span>
    </dt>
    <dd>{{% md %}}Forces the request to use SSL (Redirects a non-SSL request to SSL).
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>geo<wbr>Headers</span>
        <span class="property-indicator"></span>
        <span class="property-type">bool</span>
    </dt>
    <dd>{{% md %}}Injects Fastly-Geo-Country, Fastly-Geo-City, and
Fastly-Geo-Region into the request headers.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>hash<wbr>Keys</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}Comma separated list of varnish request object fields
that should be in the hash key.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>max<wbr>Stale<wbr>Age</span>
        <span class="property-indicator"></span>
        <span class="property-type">float</span>
    </dt>
    <dd>{{% md %}}How old an object is allowed to be to serve
`stale-if-error` or `stale-while-revalidate`, in seconds.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>name</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}A unique name to identify this dictionary.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>request<wbr>Condition</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}Name of already defined `condition` to be checked during the request phase. If the condition passes then this object will be delivered. This `condition` must be of type `REQUEST`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>timer<wbr>Support</span>
        <span class="property-indicator"></span>
        <span class="property-type">bool</span>
    </dt>
    <dd>{{% md %}}Injects the X-Timer info into the request for
viewing origin fetch durations.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>xff</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}X-Forwarded-For, should be `clear`, `leave`, `append`,
`append_all`, or `overwrite`. Default `append`.
{{% /md %}}</dd>

</dl>
{{% /choosable %}}





<h4>Servicev1Response<wbr>Object</h4>
{{% choosable language nodejs %}}
> See the <a href="/docs/reference/pkg/nodejs/pulumi/fastly/types/input/#Servicev1ResponseObject">input</a> and <a href="/docs/reference/pkg/nodejs/pulumi/fastly/types/output/#Servicev1ResponseObject">output</a> API doc for this type.
{{% /choosable %}}

{{% choosable language go %}}
> See the <a href="https://pkg.go.dev/github.com/pulumi/pulumi-fastly/sdk/go/fastly/?tab=doc#Servicev1ResponseObjectArgs">input</a> and <a href="https://pkg.go.dev/github.com/pulumi/pulumi-fastly/sdk/go/fastly/?tab=doc#Servicev1ResponseObjectOutput">output</a> API doc for this type.
{{% /choosable %}}




{{% choosable language csharp %}}
<dl class="resources-properties">

    <dt class="property-optional"
            title="Optional">
        <span>Cache<wbr>Condition</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}Name of already defined `condition` to check after we have retrieved an object. If the condition passes then deliver this Request Object instead. This `condition` must be of type `CACHE`. For detailed information about Conditionals,
see [Fastly's Documentation on Conditionals][fastly-conditionals].
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Content</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}The custom VCL code to upload.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Content<wbr>Type</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}The MIME type of the content.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>Name</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}A unique name to identify this dictionary.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Request<wbr>Condition</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}Name of already defined `condition` to be checked during the request phase. If the condition passes then this object will be delivered. This `condition` must be of type `REQUEST`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Response</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}The HTTP Response. Default `Ok`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Status</span>
        <span class="property-indicator"></span>
        <span class="property-type">int?</span>
    </dt>
    <dd>{{% md %}}The HTTP Status Code. Default `200`.
{{% /md %}}</dd>

</dl>
{{% /choosable %}}


{{% choosable language go %}}
<dl class="resources-properties">

    <dt class="property-optional"
            title="Optional">
        <span>Cache<wbr>Condition</span>
        <span class="property-indicator"></span>
        <span class="property-type">*string</span>
    </dt>
    <dd>{{% md %}}Name of already defined `condition` to check after we have retrieved an object. If the condition passes then deliver this Request Object instead. This `condition` must be of type `CACHE`. For detailed information about Conditionals,
see [Fastly's Documentation on Conditionals][fastly-conditionals].
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Content</span>
        <span class="property-indicator"></span>
        <span class="property-type">*string</span>
    </dt>
    <dd>{{% md %}}The custom VCL code to upload.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Content<wbr>Type</span>
        <span class="property-indicator"></span>
        <span class="property-type">*string</span>
    </dt>
    <dd>{{% md %}}The MIME type of the content.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>Name</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}A unique name to identify this dictionary.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Request<wbr>Condition</span>
        <span class="property-indicator"></span>
        <span class="property-type">*string</span>
    </dt>
    <dd>{{% md %}}Name of already defined `condition` to be checked during the request phase. If the condition passes then this object will be delivered. This `condition` must be of type `REQUEST`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Response</span>
        <span class="property-indicator"></span>
        <span class="property-type">*string</span>
    </dt>
    <dd>{{% md %}}The HTTP Response. Default `Ok`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Status</span>
        <span class="property-indicator"></span>
        <span class="property-type">*int</span>
    </dt>
    <dd>{{% md %}}The HTTP Status Code. Default `200`.
{{% /md %}}</dd>

</dl>
{{% /choosable %}}


{{% choosable language nodejs %}}
<dl class="resources-properties">

    <dt class="property-optional"
            title="Optional">
        <span>cache<wbr>Condition</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}Name of already defined `condition` to check after we have retrieved an object. If the condition passes then deliver this Request Object instead. This `condition` must be of type `CACHE`. For detailed information about Conditionals,
see [Fastly's Documentation on Conditionals][fastly-conditionals].
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>content</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}The custom VCL code to upload.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>content<wbr>Type</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}The MIME type of the content.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>name</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}A unique name to identify this dictionary.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>request<wbr>Condition</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}Name of already defined `condition` to be checked during the request phase. If the condition passes then this object will be delivered. This `condition` must be of type `REQUEST`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>response</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}The HTTP Response. Default `Ok`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>status</span>
        <span class="property-indicator"></span>
        <span class="property-type">number?</span>
    </dt>
    <dd>{{% md %}}The HTTP Status Code. Default `200`.
{{% /md %}}</dd>

</dl>
{{% /choosable %}}


{{% choosable language python %}}
<dl class="resources-properties">

    <dt class="property-optional"
            title="Optional">
        <span>cache<wbr>Condition</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}Name of already defined `condition` to check after we have retrieved an object. If the condition passes then deliver this Request Object instead. This `condition` must be of type `CACHE`. For detailed information about Conditionals,
see [Fastly's Documentation on Conditionals][fastly-conditionals].
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>content</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}The custom VCL code to upload.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>content<wbr>Type</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}The MIME type of the content.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>name</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}A unique name to identify this dictionary.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>request<wbr>Condition</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}Name of already defined `condition` to be checked during the request phase. If the condition passes then this object will be delivered. This `condition` must be of type `REQUEST`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>response</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}The HTTP Response. Default `Ok`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>status</span>
        <span class="property-indicator"></span>
        <span class="property-type">float</span>
    </dt>
    <dd>{{% md %}}The HTTP Status Code. Default `200`.
{{% /md %}}</dd>

</dl>
{{% /choosable %}}





<h4>Servicev1S3logging</h4>
{{% choosable language nodejs %}}
> See the <a href="/docs/reference/pkg/nodejs/pulumi/fastly/types/input/#Servicev1S3logging">input</a> and <a href="/docs/reference/pkg/nodejs/pulumi/fastly/types/output/#Servicev1S3logging">output</a> API doc for this type.
{{% /choosable %}}

{{% choosable language go %}}
> See the <a href="https://pkg.go.dev/github.com/pulumi/pulumi-fastly/sdk/go/fastly/?tab=doc#Servicev1S3loggingArgs">input</a> and <a href="https://pkg.go.dev/github.com/pulumi/pulumi-fastly/sdk/go/fastly/?tab=doc#Servicev1S3loggingOutput">output</a> API doc for this type.
{{% /choosable %}}




{{% choosable language csharp %}}
<dl class="resources-properties">

    <dt class="property-required"
            title="Required">
        <span>Bucket<wbr>Name</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}The name of the bucket in which to store the logs.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Domain</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}If you created the S3 bucket outside of `us-east-1`,
then specify the corresponding bucket endpoint. Example: `s3-us-west-2.amazonaws.com`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Format</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}Apache-style string or VCL variables to use for log formatting. Default `%h %l %u %t \"%r\" %>s %b`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Format<wbr>Version</span>
        <span class="property-indicator"></span>
        <span class="property-type">int?</span>
    </dt>
    <dd>{{% md %}}The version of the custom logging format used for the configured endpoint. Can be either `1` or `2`. The logging call gets placed by default in `vcl_log` if `format_version` is set to `2` and in `vcl_deliver` if `format_version` is set to `1`. Default `2`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Gzip<wbr>Level</span>
        <span class="property-indicator"></span>
        <span class="property-type">int?</span>
    </dt>
    <dd>{{% md %}}Level of GZIP compression from `0`to `9`. `0` means no compression. `1` is the fastest and the least compressed version, `9` is the slowest and the most compressed version. Default `0`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Message<wbr>Type</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}How the message should be formatted. Can be either `classic`, `loggly`, `logplex` or `blank`.  Default `classic`.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>Name</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}A unique name to identify this dictionary.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Path</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}The path to upload logs to. Must end with a trailing slash. If this field is left empty, the files will be saved in the container's root path.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Period</span>
        <span class="property-indicator"></span>
        <span class="property-type">int?</span>
    </dt>
    <dd>{{% md %}}How frequently the logs should be transferred in seconds. Default `3600`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Placement</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}Where in the generated VCL the logging call should be placed, overriding any `format_version` default. Can be either `none` or `waf_debug`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Redundancy</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}The S3 redundancy level. Should be formatted; one of: `standard`, `reduced_redundancy` or null. Default `null`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Response<wbr>Condition</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}The name of the `condition` to apply. If empty, always execute.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>S3Access<wbr>Key</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}AWS Access Key of an account with the required
permissions to post logs. It is **strongly** recommended you create a separate
IAM user with permissions to only operate on this Bucket. This key will be
not be encrypted. You can provide this key via an environment variable, `FASTLY_S3_ACCESS_KEY`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>S3Secret<wbr>Key</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}AWS Secret Key of an account with the required
permissions to post logs. It is **strongly** recommended you create a separate
IAM user with permissions to only operate on this Bucket. This secret will be
not be encrypted. You can provide this secret via an environment variable, `FASTLY_S3_SECRET_KEY`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Server<wbr>Side<wbr>Encryption</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Server<wbr>Side<wbr>Encryption<wbr>Kms<wbr>Key<wbr>Id</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Timestamp<wbr>Format</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}`strftime` specified timestamp formatting. Default `%Y-%m-%dT%H:%M:%S.000`.
{{% /md %}}</dd>

</dl>
{{% /choosable %}}


{{% choosable language go %}}
<dl class="resources-properties">

    <dt class="property-required"
            title="Required">
        <span>Bucket<wbr>Name</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}The name of the bucket in which to store the logs.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Domain</span>
        <span class="property-indicator"></span>
        <span class="property-type">*string</span>
    </dt>
    <dd>{{% md %}}If you created the S3 bucket outside of `us-east-1`,
then specify the corresponding bucket endpoint. Example: `s3-us-west-2.amazonaws.com`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Format</span>
        <span class="property-indicator"></span>
        <span class="property-type">*string</span>
    </dt>
    <dd>{{% md %}}Apache-style string or VCL variables to use for log formatting. Default `%h %l %u %t \"%r\" %>s %b`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Format<wbr>Version</span>
        <span class="property-indicator"></span>
        <span class="property-type">*int</span>
    </dt>
    <dd>{{% md %}}The version of the custom logging format used for the configured endpoint. Can be either `1` or `2`. The logging call gets placed by default in `vcl_log` if `format_version` is set to `2` and in `vcl_deliver` if `format_version` is set to `1`. Default `2`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Gzip<wbr>Level</span>
        <span class="property-indicator"></span>
        <span class="property-type">*int</span>
    </dt>
    <dd>{{% md %}}Level of GZIP compression from `0`to `9`. `0` means no compression. `1` is the fastest and the least compressed version, `9` is the slowest and the most compressed version. Default `0`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Message<wbr>Type</span>
        <span class="property-indicator"></span>
        <span class="property-type">*string</span>
    </dt>
    <dd>{{% md %}}How the message should be formatted. Can be either `classic`, `loggly`, `logplex` or `blank`.  Default `classic`.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>Name</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}A unique name to identify this dictionary.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Path</span>
        <span class="property-indicator"></span>
        <span class="property-type">*string</span>
    </dt>
    <dd>{{% md %}}The path to upload logs to. Must end with a trailing slash. If this field is left empty, the files will be saved in the container's root path.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Period</span>
        <span class="property-indicator"></span>
        <span class="property-type">*int</span>
    </dt>
    <dd>{{% md %}}How frequently the logs should be transferred in seconds. Default `3600`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Placement</span>
        <span class="property-indicator"></span>
        <span class="property-type">*string</span>
    </dt>
    <dd>{{% md %}}Where in the generated VCL the logging call should be placed, overriding any `format_version` default. Can be either `none` or `waf_debug`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Redundancy</span>
        <span class="property-indicator"></span>
        <span class="property-type">*string</span>
    </dt>
    <dd>{{% md %}}The S3 redundancy level. Should be formatted; one of: `standard`, `reduced_redundancy` or null. Default `null`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Response<wbr>Condition</span>
        <span class="property-indicator"></span>
        <span class="property-type">*string</span>
    </dt>
    <dd>{{% md %}}The name of the `condition` to apply. If empty, always execute.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>S3Access<wbr>Key</span>
        <span class="property-indicator"></span>
        <span class="property-type">*string</span>
    </dt>
    <dd>{{% md %}}AWS Access Key of an account with the required
permissions to post logs. It is **strongly** recommended you create a separate
IAM user with permissions to only operate on this Bucket. This key will be
not be encrypted. You can provide this key via an environment variable, `FASTLY_S3_ACCESS_KEY`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>S3Secret<wbr>Key</span>
        <span class="property-indicator"></span>
        <span class="property-type">*string</span>
    </dt>
    <dd>{{% md %}}AWS Secret Key of an account with the required
permissions to post logs. It is **strongly** recommended you create a separate
IAM user with permissions to only operate on this Bucket. This secret will be
not be encrypted. You can provide this secret via an environment variable, `FASTLY_S3_SECRET_KEY`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Server<wbr>Side<wbr>Encryption</span>
        <span class="property-indicator"></span>
        <span class="property-type">*string</span>
    </dt>
    <dd>{{% md %}}{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Server<wbr>Side<wbr>Encryption<wbr>Kms<wbr>Key<wbr>Id</span>
        <span class="property-indicator"></span>
        <span class="property-type">*string</span>
    </dt>
    <dd>{{% md %}}{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Timestamp<wbr>Format</span>
        <span class="property-indicator"></span>
        <span class="property-type">*string</span>
    </dt>
    <dd>{{% md %}}`strftime` specified timestamp formatting. Default `%Y-%m-%dT%H:%M:%S.000`.
{{% /md %}}</dd>

</dl>
{{% /choosable %}}


{{% choosable language nodejs %}}
<dl class="resources-properties">

    <dt class="property-required"
            title="Required">
        <span>bucket<wbr>Name</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}The name of the bucket in which to store the logs.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>domain</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}If you created the S3 bucket outside of `us-east-1`,
then specify the corresponding bucket endpoint. Example: `s3-us-west-2.amazonaws.com`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>format</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}Apache-style string or VCL variables to use for log formatting. Default `%h %l %u %t \"%r\" %>s %b`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>format<wbr>Version</span>
        <span class="property-indicator"></span>
        <span class="property-type">number?</span>
    </dt>
    <dd>{{% md %}}The version of the custom logging format used for the configured endpoint. Can be either `1` or `2`. The logging call gets placed by default in `vcl_log` if `format_version` is set to `2` and in `vcl_deliver` if `format_version` is set to `1`. Default `2`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>gzip<wbr>Level</span>
        <span class="property-indicator"></span>
        <span class="property-type">number?</span>
    </dt>
    <dd>{{% md %}}Level of GZIP compression from `0`to `9`. `0` means no compression. `1` is the fastest and the least compressed version, `9` is the slowest and the most compressed version. Default `0`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>message<wbr>Type</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}How the message should be formatted. Can be either `classic`, `loggly`, `logplex` or `blank`.  Default `classic`.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>name</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}A unique name to identify this dictionary.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>path</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}The path to upload logs to. Must end with a trailing slash. If this field is left empty, the files will be saved in the container's root path.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>period</span>
        <span class="property-indicator"></span>
        <span class="property-type">number?</span>
    </dt>
    <dd>{{% md %}}How frequently the logs should be transferred in seconds. Default `3600`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>placement</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}Where in the generated VCL the logging call should be placed, overriding any `format_version` default. Can be either `none` or `waf_debug`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>redundancy</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}The S3 redundancy level. Should be formatted; one of: `standard`, `reduced_redundancy` or null. Default `null`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>response<wbr>Condition</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}The name of the `condition` to apply. If empty, always execute.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>s3Access<wbr>Key</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}AWS Access Key of an account with the required
permissions to post logs. It is **strongly** recommended you create a separate
IAM user with permissions to only operate on this Bucket. This key will be
not be encrypted. You can provide this key via an environment variable, `FASTLY_S3_ACCESS_KEY`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>s3Secret<wbr>Key</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}AWS Secret Key of an account with the required
permissions to post logs. It is **strongly** recommended you create a separate
IAM user with permissions to only operate on this Bucket. This secret will be
not be encrypted. You can provide this secret via an environment variable, `FASTLY_S3_SECRET_KEY`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>server<wbr>Side<wbr>Encryption</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>server<wbr>Side<wbr>Encryption<wbr>Kms<wbr>Key<wbr>Id</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>timestamp<wbr>Format</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}`strftime` specified timestamp formatting. Default `%Y-%m-%dT%H:%M:%S.000`.
{{% /md %}}</dd>

</dl>
{{% /choosable %}}


{{% choosable language python %}}
<dl class="resources-properties">

    <dt class="property-required"
            title="Required">
        <span>bucket<wbr>Name</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}The name of the bucket in which to store the logs.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>domain</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}If you created the S3 bucket outside of `us-east-1`,
then specify the corresponding bucket endpoint. Example: `s3-us-west-2.amazonaws.com`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>format</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}Apache-style string or VCL variables to use for log formatting. Default `%h %l %u %t \"%r\" %>s %b`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>format<wbr>Version</span>
        <span class="property-indicator"></span>
        <span class="property-type">float</span>
    </dt>
    <dd>{{% md %}}The version of the custom logging format used for the configured endpoint. Can be either `1` or `2`. The logging call gets placed by default in `vcl_log` if `format_version` is set to `2` and in `vcl_deliver` if `format_version` is set to `1`. Default `2`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>gzip<wbr>Level</span>
        <span class="property-indicator"></span>
        <span class="property-type">float</span>
    </dt>
    <dd>{{% md %}}Level of GZIP compression from `0`to `9`. `0` means no compression. `1` is the fastest and the least compressed version, `9` is the slowest and the most compressed version. Default `0`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>message<wbr>Type</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}How the message should be formatted. Can be either `classic`, `loggly`, `logplex` or `blank`.  Default `classic`.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>name</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}A unique name to identify this dictionary.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>path</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}The path to upload logs to. Must end with a trailing slash. If this field is left empty, the files will be saved in the container's root path.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>period</span>
        <span class="property-indicator"></span>
        <span class="property-type">float</span>
    </dt>
    <dd>{{% md %}}How frequently the logs should be transferred in seconds. Default `3600`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>placement</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}Where in the generated VCL the logging call should be placed, overriding any `format_version` default. Can be either `none` or `waf_debug`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>redundancy</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}The S3 redundancy level. Should be formatted; one of: `standard`, `reduced_redundancy` or null. Default `null`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>response<wbr>Condition</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}The name of the `condition` to apply. If empty, always execute.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>s3Access<wbr>Key</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}AWS Access Key of an account with the required
permissions to post logs. It is **strongly** recommended you create a separate
IAM user with permissions to only operate on this Bucket. This key will be
not be encrypted. You can provide this key via an environment variable, `FASTLY_S3_ACCESS_KEY`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>s3Secret<wbr>Key</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}AWS Secret Key of an account with the required
permissions to post logs. It is **strongly** recommended you create a separate
IAM user with permissions to only operate on this Bucket. This secret will be
not be encrypted. You can provide this secret via an environment variable, `FASTLY_S3_SECRET_KEY`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>server<wbr>Side<wbr>Encryption</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>server<wbr>Side<wbr>Encryption<wbr>Kms<wbr>Key<wbr>Id</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>timestamp<wbr>Format</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}`strftime` specified timestamp formatting. Default `%Y-%m-%dT%H:%M:%S.000`.
{{% /md %}}</dd>

</dl>
{{% /choosable %}}





<h4>Servicev1Snippet</h4>
{{% choosable language nodejs %}}
> See the <a href="/docs/reference/pkg/nodejs/pulumi/fastly/types/input/#Servicev1Snippet">input</a> and <a href="/docs/reference/pkg/nodejs/pulumi/fastly/types/output/#Servicev1Snippet">output</a> API doc for this type.
{{% /choosable %}}

{{% choosable language go %}}
> See the <a href="https://pkg.go.dev/github.com/pulumi/pulumi-fastly/sdk/go/fastly/?tab=doc#Servicev1SnippetArgs">input</a> and <a href="https://pkg.go.dev/github.com/pulumi/pulumi-fastly/sdk/go/fastly/?tab=doc#Servicev1SnippetOutput">output</a> API doc for this type.
{{% /choosable %}}




{{% choosable language csharp %}}
<dl class="resources-properties">

    <dt class="property-required"
            title="Required">
        <span>Content</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}The custom VCL code to upload.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>Name</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}A unique name to identify this dictionary.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Priority</span>
        <span class="property-indicator"></span>
        <span class="property-type">int?</span>
    </dt>
    <dd>{{% md %}}Priority determines the ordering for multiple snippets. Lower numbers execute first.  Defaults to `100`.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>Type</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}The location in generated VCL where the snippet should be placed (can be one of `init`, `recv`, `hit`, `miss`, `pass`, `fetch`, `error`, `deliver`, `log` or `none`).
{{% /md %}}</dd>

</dl>
{{% /choosable %}}


{{% choosable language go %}}
<dl class="resources-properties">

    <dt class="property-required"
            title="Required">
        <span>Content</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}The custom VCL code to upload.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>Name</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}A unique name to identify this dictionary.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Priority</span>
        <span class="property-indicator"></span>
        <span class="property-type">*int</span>
    </dt>
    <dd>{{% md %}}Priority determines the ordering for multiple snippets. Lower numbers execute first.  Defaults to `100`.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>Type</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}The location in generated VCL where the snippet should be placed (can be one of `init`, `recv`, `hit`, `miss`, `pass`, `fetch`, `error`, `deliver`, `log` or `none`).
{{% /md %}}</dd>

</dl>
{{% /choosable %}}


{{% choosable language nodejs %}}
<dl class="resources-properties">

    <dt class="property-required"
            title="Required">
        <span>content</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}The custom VCL code to upload.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>name</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}A unique name to identify this dictionary.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>priority</span>
        <span class="property-indicator"></span>
        <span class="property-type">number?</span>
    </dt>
    <dd>{{% md %}}Priority determines the ordering for multiple snippets. Lower numbers execute first.  Defaults to `100`.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>type</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}The location in generated VCL where the snippet should be placed (can be one of `init`, `recv`, `hit`, `miss`, `pass`, `fetch`, `error`, `deliver`, `log` or `none`).
{{% /md %}}</dd>

</dl>
{{% /choosable %}}


{{% choosable language python %}}
<dl class="resources-properties">

    <dt class="property-required"
            title="Required">
        <span>content</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}The custom VCL code to upload.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>name</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}A unique name to identify this dictionary.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>priority</span>
        <span class="property-indicator"></span>
        <span class="property-type">float</span>
    </dt>
    <dd>{{% md %}}Priority determines the ordering for multiple snippets. Lower numbers execute first.  Defaults to `100`.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>type</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}The location in generated VCL where the snippet should be placed (can be one of `init`, `recv`, `hit`, `miss`, `pass`, `fetch`, `error`, `deliver`, `log` or `none`).
{{% /md %}}</dd>

</dl>
{{% /choosable %}}





<h4>Servicev1Splunk</h4>
{{% choosable language nodejs %}}
> See the <a href="/docs/reference/pkg/nodejs/pulumi/fastly/types/input/#Servicev1Splunk">input</a> and <a href="/docs/reference/pkg/nodejs/pulumi/fastly/types/output/#Servicev1Splunk">output</a> API doc for this type.
{{% /choosable %}}

{{% choosable language go %}}
> See the <a href="https://pkg.go.dev/github.com/pulumi/pulumi-fastly/sdk/go/fastly/?tab=doc#Servicev1SplunkArgs">input</a> and <a href="https://pkg.go.dev/github.com/pulumi/pulumi-fastly/sdk/go/fastly/?tab=doc#Servicev1SplunkOutput">output</a> API doc for this type.
{{% /choosable %}}




{{% choosable language csharp %}}
<dl class="resources-properties">

    <dt class="property-optional"
            title="Optional">
        <span>Format</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}Apache-style string or VCL variables to use for log formatting. Default `%h %l %u %t \"%r\" %>s %b`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Format<wbr>Version</span>
        <span class="property-indicator"></span>
        <span class="property-type">int?</span>
    </dt>
    <dd>{{% md %}}The version of the custom logging format used for the configured endpoint. Can be either `1` or `2`. The logging call gets placed by default in `vcl_log` if `format_version` is set to `2` and in `vcl_deliver` if `format_version` is set to `1`. Default `2`.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>Name</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}A unique name to identify this dictionary.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Placement</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}Where in the generated VCL the logging call should be placed, overriding any `format_version` default. Can be either `none` or `waf_debug`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Response<wbr>Condition</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}The name of the `condition` to apply. If empty, always execute.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>Token</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}The Splunk token to be used for authentication.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>Url</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}The Splunk URL to stream logs to.
{{% /md %}}</dd>

</dl>
{{% /choosable %}}


{{% choosable language go %}}
<dl class="resources-properties">

    <dt class="property-optional"
            title="Optional">
        <span>Format</span>
        <span class="property-indicator"></span>
        <span class="property-type">*string</span>
    </dt>
    <dd>{{% md %}}Apache-style string or VCL variables to use for log formatting. Default `%h %l %u %t \"%r\" %>s %b`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Format<wbr>Version</span>
        <span class="property-indicator"></span>
        <span class="property-type">*int</span>
    </dt>
    <dd>{{% md %}}The version of the custom logging format used for the configured endpoint. Can be either `1` or `2`. The logging call gets placed by default in `vcl_log` if `format_version` is set to `2` and in `vcl_deliver` if `format_version` is set to `1`. Default `2`.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>Name</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}A unique name to identify this dictionary.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Placement</span>
        <span class="property-indicator"></span>
        <span class="property-type">*string</span>
    </dt>
    <dd>{{% md %}}Where in the generated VCL the logging call should be placed, overriding any `format_version` default. Can be either `none` or `waf_debug`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Response<wbr>Condition</span>
        <span class="property-indicator"></span>
        <span class="property-type">*string</span>
    </dt>
    <dd>{{% md %}}The name of the `condition` to apply. If empty, always execute.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>Token</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}The Splunk token to be used for authentication.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>Url</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}The Splunk URL to stream logs to.
{{% /md %}}</dd>

</dl>
{{% /choosable %}}


{{% choosable language nodejs %}}
<dl class="resources-properties">

    <dt class="property-optional"
            title="Optional">
        <span>format</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}Apache-style string or VCL variables to use for log formatting. Default `%h %l %u %t \"%r\" %>s %b`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>format<wbr>Version</span>
        <span class="property-indicator"></span>
        <span class="property-type">number?</span>
    </dt>
    <dd>{{% md %}}The version of the custom logging format used for the configured endpoint. Can be either `1` or `2`. The logging call gets placed by default in `vcl_log` if `format_version` is set to `2` and in `vcl_deliver` if `format_version` is set to `1`. Default `2`.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>name</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}A unique name to identify this dictionary.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>placement</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}Where in the generated VCL the logging call should be placed, overriding any `format_version` default. Can be either `none` or `waf_debug`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>response<wbr>Condition</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}The name of the `condition` to apply. If empty, always execute.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>token</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}The Splunk token to be used for authentication.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>url</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}The Splunk URL to stream logs to.
{{% /md %}}</dd>

</dl>
{{% /choosable %}}


{{% choosable language python %}}
<dl class="resources-properties">

    <dt class="property-optional"
            title="Optional">
        <span>format</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}Apache-style string or VCL variables to use for log formatting. Default `%h %l %u %t \"%r\" %>s %b`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>format<wbr>Version</span>
        <span class="property-indicator"></span>
        <span class="property-type">float</span>
    </dt>
    <dd>{{% md %}}The version of the custom logging format used for the configured endpoint. Can be either `1` or `2`. The logging call gets placed by default in `vcl_log` if `format_version` is set to `2` and in `vcl_deliver` if `format_version` is set to `1`. Default `2`.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>name</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}A unique name to identify this dictionary.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>placement</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}Where in the generated VCL the logging call should be placed, overriding any `format_version` default. Can be either `none` or `waf_debug`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>response<wbr>Condition</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}The name of the `condition` to apply. If empty, always execute.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>token</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}The Splunk token to be used for authentication.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>url</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}The Splunk URL to stream logs to.
{{% /md %}}</dd>

</dl>
{{% /choosable %}}





<h4>Servicev1Sumologic</h4>
{{% choosable language nodejs %}}
> See the <a href="/docs/reference/pkg/nodejs/pulumi/fastly/types/input/#Servicev1Sumologic">input</a> and <a href="/docs/reference/pkg/nodejs/pulumi/fastly/types/output/#Servicev1Sumologic">output</a> API doc for this type.
{{% /choosable %}}

{{% choosable language go %}}
> See the <a href="https://pkg.go.dev/github.com/pulumi/pulumi-fastly/sdk/go/fastly/?tab=doc#Servicev1SumologicArgs">input</a> and <a href="https://pkg.go.dev/github.com/pulumi/pulumi-fastly/sdk/go/fastly/?tab=doc#Servicev1SumologicOutput">output</a> API doc for this type.
{{% /choosable %}}




{{% choosable language csharp %}}
<dl class="resources-properties">

    <dt class="property-optional"
            title="Optional">
        <span>Format</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}Apache-style string or VCL variables to use for log formatting. Default `%h %l %u %t \"%r\" %>s %b`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Format<wbr>Version</span>
        <span class="property-indicator"></span>
        <span class="property-type">int?</span>
    </dt>
    <dd>{{% md %}}The version of the custom logging format used for the configured endpoint. Can be either `1` or `2`. The logging call gets placed by default in `vcl_log` if `format_version` is set to `2` and in `vcl_deliver` if `format_version` is set to `1`. Default `2`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Message<wbr>Type</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}How the message should be formatted. Can be either `classic`, `loggly`, `logplex` or `blank`.  Default `classic`.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>Name</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}A unique name to identify this dictionary.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Placement</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}Where in the generated VCL the logging call should be placed, overriding any `format_version` default. Can be either `none` or `waf_debug`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Response<wbr>Condition</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}The name of the `condition` to apply. If empty, always execute.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>Url</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}The Splunk URL to stream logs to.
{{% /md %}}</dd>

</dl>
{{% /choosable %}}


{{% choosable language go %}}
<dl class="resources-properties">

    <dt class="property-optional"
            title="Optional">
        <span>Format</span>
        <span class="property-indicator"></span>
        <span class="property-type">*string</span>
    </dt>
    <dd>{{% md %}}Apache-style string or VCL variables to use for log formatting. Default `%h %l %u %t \"%r\" %>s %b`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Format<wbr>Version</span>
        <span class="property-indicator"></span>
        <span class="property-type">*int</span>
    </dt>
    <dd>{{% md %}}The version of the custom logging format used for the configured endpoint. Can be either `1` or `2`. The logging call gets placed by default in `vcl_log` if `format_version` is set to `2` and in `vcl_deliver` if `format_version` is set to `1`. Default `2`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Message<wbr>Type</span>
        <span class="property-indicator"></span>
        <span class="property-type">*string</span>
    </dt>
    <dd>{{% md %}}How the message should be formatted. Can be either `classic`, `loggly`, `logplex` or `blank`.  Default `classic`.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>Name</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}A unique name to identify this dictionary.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Placement</span>
        <span class="property-indicator"></span>
        <span class="property-type">*string</span>
    </dt>
    <dd>{{% md %}}Where in the generated VCL the logging call should be placed, overriding any `format_version` default. Can be either `none` or `waf_debug`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Response<wbr>Condition</span>
        <span class="property-indicator"></span>
        <span class="property-type">*string</span>
    </dt>
    <dd>{{% md %}}The name of the `condition` to apply. If empty, always execute.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>Url</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}The Splunk URL to stream logs to.
{{% /md %}}</dd>

</dl>
{{% /choosable %}}


{{% choosable language nodejs %}}
<dl class="resources-properties">

    <dt class="property-optional"
            title="Optional">
        <span>format</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}Apache-style string or VCL variables to use for log formatting. Default `%h %l %u %t \"%r\" %>s %b`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>format<wbr>Version</span>
        <span class="property-indicator"></span>
        <span class="property-type">number?</span>
    </dt>
    <dd>{{% md %}}The version of the custom logging format used for the configured endpoint. Can be either `1` or `2`. The logging call gets placed by default in `vcl_log` if `format_version` is set to `2` and in `vcl_deliver` if `format_version` is set to `1`. Default `2`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>message<wbr>Type</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}How the message should be formatted. Can be either `classic`, `loggly`, `logplex` or `blank`.  Default `classic`.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>name</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}A unique name to identify this dictionary.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>placement</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}Where in the generated VCL the logging call should be placed, overriding any `format_version` default. Can be either `none` or `waf_debug`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>response<wbr>Condition</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}The name of the `condition` to apply. If empty, always execute.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>url</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}The Splunk URL to stream logs to.
{{% /md %}}</dd>

</dl>
{{% /choosable %}}


{{% choosable language python %}}
<dl class="resources-properties">

    <dt class="property-optional"
            title="Optional">
        <span>format</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}Apache-style string or VCL variables to use for log formatting. Default `%h %l %u %t \"%r\" %>s %b`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>format<wbr>Version</span>
        <span class="property-indicator"></span>
        <span class="property-type">float</span>
    </dt>
    <dd>{{% md %}}The version of the custom logging format used for the configured endpoint. Can be either `1` or `2`. The logging call gets placed by default in `vcl_log` if `format_version` is set to `2` and in `vcl_deliver` if `format_version` is set to `1`. Default `2`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>message<wbr>Type</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}How the message should be formatted. Can be either `classic`, `loggly`, `logplex` or `blank`.  Default `classic`.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>name</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}A unique name to identify this dictionary.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>placement</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}Where in the generated VCL the logging call should be placed, overriding any `format_version` default. Can be either `none` or `waf_debug`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>response<wbr>Condition</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}The name of the `condition` to apply. If empty, always execute.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>url</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}The Splunk URL to stream logs to.
{{% /md %}}</dd>

</dl>
{{% /choosable %}}





<h4>Servicev1Syslog</h4>
{{% choosable language nodejs %}}
> See the <a href="/docs/reference/pkg/nodejs/pulumi/fastly/types/input/#Servicev1Syslog">input</a> and <a href="/docs/reference/pkg/nodejs/pulumi/fastly/types/output/#Servicev1Syslog">output</a> API doc for this type.
{{% /choosable %}}

{{% choosable language go %}}
> See the <a href="https://pkg.go.dev/github.com/pulumi/pulumi-fastly/sdk/go/fastly/?tab=doc#Servicev1SyslogArgs">input</a> and <a href="https://pkg.go.dev/github.com/pulumi/pulumi-fastly/sdk/go/fastly/?tab=doc#Servicev1SyslogOutput">output</a> API doc for this type.
{{% /choosable %}}




{{% choosable language csharp %}}
<dl class="resources-properties">

    <dt class="property-required"
            title="Required">
        <span>Address</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}A hostname or IPv4 address of the Syslog endpoint.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Format</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}Apache-style string or VCL variables to use for log formatting. Default `%h %l %u %t \"%r\" %>s %b`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Format<wbr>Version</span>
        <span class="property-indicator"></span>
        <span class="property-type">int?</span>
    </dt>
    <dd>{{% md %}}The version of the custom logging format used for the configured endpoint. Can be either `1` or `2`. The logging call gets placed by default in `vcl_log` if `format_version` is set to `2` and in `vcl_deliver` if `format_version` is set to `1`. Default `2`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Message<wbr>Type</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}How the message should be formatted. Can be either `classic`, `loggly`, `logplex` or `blank`.  Default `classic`.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>Name</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}A unique name to identify this dictionary.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Placement</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}Where in the generated VCL the logging call should be placed, overriding any `format_version` default. Can be either `none` or `waf_debug`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Port</span>
        <span class="property-indicator"></span>
        <span class="property-type">int?</span>
    </dt>
    <dd>{{% md %}}The port number configured in Logentries to send logs to. Defaults to `20000`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Response<wbr>Condition</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}The name of the `condition` to apply. If empty, always execute.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Tls<wbr>Ca<wbr>Cert</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}A secure certificate to authenticate the server with. Must be in PEM format. You can provide this certificate via an environment variable, `FASTLY_SYSLOG_CA_CERT`
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Tls<wbr>Client<wbr>Cert</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}The client certificate used to make authenticated requests. Must be in PEM format. You can provide this certificate via an environment variable, `FASTLY_SYSLOG_CLIENT_CERT`
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Tls<wbr>Client<wbr>Key</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}The client private key used to make authenticated requests. Must be in PEM format. You can provide this key via an environment variable, `FASTLY_SYSLOG_CLIENT_KEY`
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Tls<wbr>Hostname</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}Used during the TLS handshake to validate the certificate.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Token</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}The Splunk token to be used for authentication.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Use<wbr>Tls</span>
        <span class="property-indicator"></span>
        <span class="property-type">bool?</span>
    </dt>
    <dd>{{% md %}}Whether to use TLS for secure logging. Defaults to `true`
{{% /md %}}</dd>

</dl>
{{% /choosable %}}


{{% choosable language go %}}
<dl class="resources-properties">

    <dt class="property-required"
            title="Required">
        <span>Address</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}A hostname or IPv4 address of the Syslog endpoint.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Format</span>
        <span class="property-indicator"></span>
        <span class="property-type">*string</span>
    </dt>
    <dd>{{% md %}}Apache-style string or VCL variables to use for log formatting. Default `%h %l %u %t \"%r\" %>s %b`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Format<wbr>Version</span>
        <span class="property-indicator"></span>
        <span class="property-type">*int</span>
    </dt>
    <dd>{{% md %}}The version of the custom logging format used for the configured endpoint. Can be either `1` or `2`. The logging call gets placed by default in `vcl_log` if `format_version` is set to `2` and in `vcl_deliver` if `format_version` is set to `1`. Default `2`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Message<wbr>Type</span>
        <span class="property-indicator"></span>
        <span class="property-type">*string</span>
    </dt>
    <dd>{{% md %}}How the message should be formatted. Can be either `classic`, `loggly`, `logplex` or `blank`.  Default `classic`.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>Name</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}A unique name to identify this dictionary.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Placement</span>
        <span class="property-indicator"></span>
        <span class="property-type">*string</span>
    </dt>
    <dd>{{% md %}}Where in the generated VCL the logging call should be placed, overriding any `format_version` default. Can be either `none` or `waf_debug`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Port</span>
        <span class="property-indicator"></span>
        <span class="property-type">*int</span>
    </dt>
    <dd>{{% md %}}The port number configured in Logentries to send logs to. Defaults to `20000`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Response<wbr>Condition</span>
        <span class="property-indicator"></span>
        <span class="property-type">*string</span>
    </dt>
    <dd>{{% md %}}The name of the `condition` to apply. If empty, always execute.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Tls<wbr>Ca<wbr>Cert</span>
        <span class="property-indicator"></span>
        <span class="property-type">*string</span>
    </dt>
    <dd>{{% md %}}A secure certificate to authenticate the server with. Must be in PEM format. You can provide this certificate via an environment variable, `FASTLY_SYSLOG_CA_CERT`
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Tls<wbr>Client<wbr>Cert</span>
        <span class="property-indicator"></span>
        <span class="property-type">*string</span>
    </dt>
    <dd>{{% md %}}The client certificate used to make authenticated requests. Must be in PEM format. You can provide this certificate via an environment variable, `FASTLY_SYSLOG_CLIENT_CERT`
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Tls<wbr>Client<wbr>Key</span>
        <span class="property-indicator"></span>
        <span class="property-type">*string</span>
    </dt>
    <dd>{{% md %}}The client private key used to make authenticated requests. Must be in PEM format. You can provide this key via an environment variable, `FASTLY_SYSLOG_CLIENT_KEY`
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Tls<wbr>Hostname</span>
        <span class="property-indicator"></span>
        <span class="property-type">*string</span>
    </dt>
    <dd>{{% md %}}Used during the TLS handshake to validate the certificate.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Token</span>
        <span class="property-indicator"></span>
        <span class="property-type">*string</span>
    </dt>
    <dd>{{% md %}}The Splunk token to be used for authentication.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Use<wbr>Tls</span>
        <span class="property-indicator"></span>
        <span class="property-type">*bool</span>
    </dt>
    <dd>{{% md %}}Whether to use TLS for secure logging. Defaults to `true`
{{% /md %}}</dd>

</dl>
{{% /choosable %}}


{{% choosable language nodejs %}}
<dl class="resources-properties">

    <dt class="property-required"
            title="Required">
        <span>address</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}A hostname or IPv4 address of the Syslog endpoint.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>format</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}Apache-style string or VCL variables to use for log formatting. Default `%h %l %u %t \"%r\" %>s %b`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>format<wbr>Version</span>
        <span class="property-indicator"></span>
        <span class="property-type">number?</span>
    </dt>
    <dd>{{% md %}}The version of the custom logging format used for the configured endpoint. Can be either `1` or `2`. The logging call gets placed by default in `vcl_log` if `format_version` is set to `2` and in `vcl_deliver` if `format_version` is set to `1`. Default `2`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>message<wbr>Type</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}How the message should be formatted. Can be either `classic`, `loggly`, `logplex` or `blank`.  Default `classic`.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>name</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}A unique name to identify this dictionary.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>placement</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}Where in the generated VCL the logging call should be placed, overriding any `format_version` default. Can be either `none` or `waf_debug`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>port</span>
        <span class="property-indicator"></span>
        <span class="property-type">number?</span>
    </dt>
    <dd>{{% md %}}The port number configured in Logentries to send logs to. Defaults to `20000`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>response<wbr>Condition</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}The name of the `condition` to apply. If empty, always execute.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>tls<wbr>Ca<wbr>Cert</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}A secure certificate to authenticate the server with. Must be in PEM format. You can provide this certificate via an environment variable, `FASTLY_SYSLOG_CA_CERT`
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>tls<wbr>Client<wbr>Cert</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}The client certificate used to make authenticated requests. Must be in PEM format. You can provide this certificate via an environment variable, `FASTLY_SYSLOG_CLIENT_CERT`
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>tls<wbr>Client<wbr>Key</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}The client private key used to make authenticated requests. Must be in PEM format. You can provide this key via an environment variable, `FASTLY_SYSLOG_CLIENT_KEY`
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>tls<wbr>Hostname</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}Used during the TLS handshake to validate the certificate.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>token</span>
        <span class="property-indicator"></span>
        <span class="property-type">string?</span>
    </dt>
    <dd>{{% md %}}The Splunk token to be used for authentication.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>use<wbr>Tls</span>
        <span class="property-indicator"></span>
        <span class="property-type">boolean?</span>
    </dt>
    <dd>{{% md %}}Whether to use TLS for secure logging. Defaults to `true`
{{% /md %}}</dd>

</dl>
{{% /choosable %}}


{{% choosable language python %}}
<dl class="resources-properties">

    <dt class="property-required"
            title="Required">
        <span>address</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}A hostname or IPv4 address of the Syslog endpoint.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>format</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}Apache-style string or VCL variables to use for log formatting. Default `%h %l %u %t \"%r\" %>s %b`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>format<wbr>Version</span>
        <span class="property-indicator"></span>
        <span class="property-type">float</span>
    </dt>
    <dd>{{% md %}}The version of the custom logging format used for the configured endpoint. Can be either `1` or `2`. The logging call gets placed by default in `vcl_log` if `format_version` is set to `2` and in `vcl_deliver` if `format_version` is set to `1`. Default `2`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>message<wbr>Type</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}How the message should be formatted. Can be either `classic`, `loggly`, `logplex` or `blank`.  Default `classic`.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>name</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}A unique name to identify this dictionary.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>placement</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}Where in the generated VCL the logging call should be placed, overriding any `format_version` default. Can be either `none` or `waf_debug`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>port</span>
        <span class="property-indicator"></span>
        <span class="property-type">float</span>
    </dt>
    <dd>{{% md %}}The port number configured in Logentries to send logs to. Defaults to `20000`.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>response<wbr>Condition</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}The name of the `condition` to apply. If empty, always execute.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>tls<wbr>Ca<wbr>Cert</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}A secure certificate to authenticate the server with. Must be in PEM format. You can provide this certificate via an environment variable, `FASTLY_SYSLOG_CA_CERT`
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>tls<wbr>Client<wbr>Cert</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}The client certificate used to make authenticated requests. Must be in PEM format. You can provide this certificate via an environment variable, `FASTLY_SYSLOG_CLIENT_CERT`
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>tls<wbr>Client<wbr>Key</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}The client private key used to make authenticated requests. Must be in PEM format. You can provide this key via an environment variable, `FASTLY_SYSLOG_CLIENT_KEY`
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>tls<wbr>Hostname</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}Used during the TLS handshake to validate the certificate.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>token</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}The Splunk token to be used for authentication.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>use<wbr>Tls</span>
        <span class="property-indicator"></span>
        <span class="property-type">bool</span>
    </dt>
    <dd>{{% md %}}Whether to use TLS for secure logging. Defaults to `true`
{{% /md %}}</dd>

</dl>
{{% /choosable %}}





<h4>Servicev1Vcl</h4>
{{% choosable language nodejs %}}
> See the <a href="/docs/reference/pkg/nodejs/pulumi/fastly/types/input/#Servicev1Vcl">input</a> and <a href="/docs/reference/pkg/nodejs/pulumi/fastly/types/output/#Servicev1Vcl">output</a> API doc for this type.
{{% /choosable %}}

{{% choosable language go %}}
> See the <a href="https://pkg.go.dev/github.com/pulumi/pulumi-fastly/sdk/go/fastly/?tab=doc#Servicev1VclArgs">input</a> and <a href="https://pkg.go.dev/github.com/pulumi/pulumi-fastly/sdk/go/fastly/?tab=doc#Servicev1VclOutput">output</a> API doc for this type.
{{% /choosable %}}




{{% choosable language csharp %}}
<dl class="resources-properties">

    <dt class="property-required"
            title="Required">
        <span>Content</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}The custom VCL code to upload.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Main</span>
        <span class="property-indicator"></span>
        <span class="property-type">bool?</span>
    </dt>
    <dd>{{% md %}}If `true`, use this block as the main configuration. If
`false`, use this block as an includable library. Only a single VCL block can be
marked as the main block. Default is `false`.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>Name</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}A unique name to identify this dictionary.
{{% /md %}}</dd>

</dl>
{{% /choosable %}}


{{% choosable language go %}}
<dl class="resources-properties">

    <dt class="property-required"
            title="Required">
        <span>Content</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}The custom VCL code to upload.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>Main</span>
        <span class="property-indicator"></span>
        <span class="property-type">*bool</span>
    </dt>
    <dd>{{% md %}}If `true`, use this block as the main configuration. If
`false`, use this block as an includable library. Only a single VCL block can be
marked as the main block. Default is `false`.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>Name</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}A unique name to identify this dictionary.
{{% /md %}}</dd>

</dl>
{{% /choosable %}}


{{% choosable language nodejs %}}
<dl class="resources-properties">

    <dt class="property-required"
            title="Required">
        <span>content</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}The custom VCL code to upload.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>main</span>
        <span class="property-indicator"></span>
        <span class="property-type">boolean?</span>
    </dt>
    <dd>{{% md %}}If `true`, use this block as the main configuration. If
`false`, use this block as an includable library. Only a single VCL block can be
marked as the main block. Default is `false`.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>name</span>
        <span class="property-indicator"></span>
        <span class="property-type">string</span>
    </dt>
    <dd>{{% md %}}A unique name to identify this dictionary.
{{% /md %}}</dd>

</dl>
{{% /choosable %}}


{{% choosable language python %}}
<dl class="resources-properties">

    <dt class="property-required"
            title="Required">
        <span>content</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}The custom VCL code to upload.
{{% /md %}}</dd>

    <dt class="property-optional"
            title="Optional">
        <span>main</span>
        <span class="property-indicator"></span>
        <span class="property-type">bool</span>
    </dt>
    <dd>{{% md %}}If `true`, use this block as the main configuration. If
`false`, use this block as an includable library. Only a single VCL block can be
marked as the main block. Default is `false`.
{{% /md %}}</dd>

    <dt class="property-required"
            title="Required">
        <span>name</span>
        <span class="property-indicator"></span>
        <span class="property-type">str</span>
    </dt>
    <dd>{{% md %}}A unique name to identify this dictionary.
{{% /md %}}</dd>

</dl>
{{% /choosable %}}









<h3>Package Details</h3>
<dl class="package-details">
	<dt>Repository</dt>
	<dd><a href="https://github.com/GrubhubProd/pulumi-fastly">https://github.com/GrubhubProd/pulumi-fastly</a></dd>
	<dt>License</dt>
	<dd>Apache-2.0</dd>
    
</dl>
