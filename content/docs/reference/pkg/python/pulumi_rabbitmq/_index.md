---
title: Package pulumi_rabbitmq
title_tag: Package pulumi_rabbitmq | Python SDK
linktitle: pulumi_rabbitmq
notitle: true
block_external_search_index: true
---

{{< resource-docs-alert "rabbitmq" >}}

<div class="section" id="pulumi-rabbitmq">
<h1>Pulumi RabbitMQ<a class="headerlink" href="#pulumi-rabbitmq" title="Permalink to this headline">¶</a></h1>
<blockquote>
<div><p>This provider is a derived work of the <a class="reference external" href="https://github.com/terraform-providers/terraform-provider-rabbitmq">Terraform Provider</a> distributed under
<a class="reference external" href="https://www.mozilla.org/en-US/MPL/2.0/">MPL 2.0</a>. If you encounter a bug or missing feature, first check the
<a class="reference external" href="https://github.com/pulumi/pulumi-rabbitmq/issues">pulumi/pulumi-rabbitmq repo</a>; however, if that doesn’t turn up
anything, please consult the source <a class="reference external" href="https://github.com/terraform-providers/terraform-provider-rabbitmq/issues">terraform-providers/terraform-provider-rabbitmq repo</a>.</p>
</div></blockquote>
<span class="target" id="module-pulumi_rabbitmq"></span><dl class="py class">
<dt id="pulumi_rabbitmq.Binding">
<em class="property">class </em><code class="sig-prename descclassname">pulumi_rabbitmq.</code><code class="sig-name descname">Binding</code><span class="sig-paren">(</span><em class="sig-param"><span class="n">resource_name</span></em>, <em class="sig-param"><span class="n">opts</span><span class="o">=</span><span class="default_value">None</span></em>, <em class="sig-param"><span class="n">arguments</span><span class="o">=</span><span class="default_value">None</span></em>, <em class="sig-param"><span class="n">arguments_json</span><span class="o">=</span><span class="default_value">None</span></em>, <em class="sig-param"><span class="n">destination</span><span class="o">=</span><span class="default_value">None</span></em>, <em class="sig-param"><span class="n">destination_type</span><span class="o">=</span><span class="default_value">None</span></em>, <em class="sig-param"><span class="n">routing_key</span><span class="o">=</span><span class="default_value">None</span></em>, <em class="sig-param"><span class="n">source</span><span class="o">=</span><span class="default_value">None</span></em>, <em class="sig-param"><span class="n">vhost</span><span class="o">=</span><span class="default_value">None</span></em>, <em class="sig-param"><span class="n">__props__</span><span class="o">=</span><span class="default_value">None</span></em>, <em class="sig-param"><span class="n">__name__</span><span class="o">=</span><span class="default_value">None</span></em>, <em class="sig-param"><span class="n">__opts__</span><span class="o">=</span><span class="default_value">None</span></em><span class="sig-paren">)</span><a class="headerlink" href="#pulumi_rabbitmq.Binding" title="Permalink to this definition">¶</a></dt>
<dd><p>The <code class="docutils literal notranslate"><span class="pre">Binding</span></code> resource creates and manages a binding relationship
between a queue an exchange.</p>
<div class="highlight-python notranslate"><div class="highlight"><pre><span></span><span class="kn">import</span> <span class="nn">pulumi</span>
<span class="kn">import</span> <span class="nn">pulumi_rabbitmq</span> <span class="k">as</span> <span class="nn">rabbitmq</span>

<span class="n">test_v_host</span> <span class="o">=</span> <span class="n">rabbitmq</span><span class="o">.</span><span class="n">VHost</span><span class="p">(</span><span class="s2">&quot;testVHost&quot;</span><span class="p">)</span>
<span class="n">guest</span> <span class="o">=</span> <span class="n">rabbitmq</span><span class="o">.</span><span class="n">Permissions</span><span class="p">(</span><span class="s2">&quot;guest&quot;</span><span class="p">,</span>
    <span class="n">permissions</span><span class="o">=</span><span class="p">{</span>
        <span class="s2">&quot;configure&quot;</span><span class="p">:</span> <span class="s2">&quot;.*&quot;</span><span class="p">,</span>
        <span class="s2">&quot;read&quot;</span><span class="p">:</span> <span class="s2">&quot;.*&quot;</span><span class="p">,</span>
        <span class="s2">&quot;write&quot;</span><span class="p">:</span> <span class="s2">&quot;.*&quot;</span><span class="p">,</span>
    <span class="p">},</span>
    <span class="n">user</span><span class="o">=</span><span class="s2">&quot;guest&quot;</span><span class="p">,</span>
    <span class="n">vhost</span><span class="o">=</span><span class="n">test_v_host</span><span class="o">.</span><span class="n">name</span><span class="p">)</span>
<span class="n">test_exchange</span> <span class="o">=</span> <span class="n">rabbitmq</span><span class="o">.</span><span class="n">Exchange</span><span class="p">(</span><span class="s2">&quot;testExchange&quot;</span><span class="p">,</span>
    <span class="n">settings</span><span class="o">=</span><span class="p">{</span>
        <span class="s2">&quot;autoDelete&quot;</span><span class="p">:</span> <span class="kc">True</span><span class="p">,</span>
        <span class="s2">&quot;durable&quot;</span><span class="p">:</span> <span class="kc">False</span><span class="p">,</span>
        <span class="s2">&quot;type&quot;</span><span class="p">:</span> <span class="s2">&quot;fanout&quot;</span><span class="p">,</span>
    <span class="p">},</span>
    <span class="n">vhost</span><span class="o">=</span><span class="n">guest</span><span class="o">.</span><span class="n">vhost</span><span class="p">)</span>
<span class="n">test_queue</span> <span class="o">=</span> <span class="n">rabbitmq</span><span class="o">.</span><span class="n">Queue</span><span class="p">(</span><span class="s2">&quot;testQueue&quot;</span><span class="p">,</span>
    <span class="n">settings</span><span class="o">=</span><span class="p">{</span>
        <span class="s2">&quot;autoDelete&quot;</span><span class="p">:</span> <span class="kc">False</span><span class="p">,</span>
        <span class="s2">&quot;durable&quot;</span><span class="p">:</span> <span class="kc">True</span><span class="p">,</span>
    <span class="p">},</span>
    <span class="n">vhost</span><span class="o">=</span><span class="n">guest</span><span class="o">.</span><span class="n">vhost</span><span class="p">)</span>
<span class="n">test_binding</span> <span class="o">=</span> <span class="n">rabbitmq</span><span class="o">.</span><span class="n">Binding</span><span class="p">(</span><span class="s2">&quot;testBinding&quot;</span><span class="p">,</span>
    <span class="n">destination</span><span class="o">=</span><span class="n">test_queue</span><span class="o">.</span><span class="n">name</span><span class="p">,</span>
    <span class="n">destination_type</span><span class="o">=</span><span class="s2">&quot;queue&quot;</span><span class="p">,</span>
    <span class="n">routing_key</span><span class="o">=</span><span class="s2">&quot;#&quot;</span><span class="p">,</span>
    <span class="n">source</span><span class="o">=</span><span class="n">test_exchange</span><span class="o">.</span><span class="n">name</span><span class="p">,</span>
    <span class="n">vhost</span><span class="o">=</span><span class="n">test_v_host</span><span class="o">.</span><span class="n">name</span><span class="p">)</span>
</pre></div>
</div>
<dl class="field-list simple">
<dt class="field-odd">Parameters</dt>
<dd class="field-odd"><ul class="simple">
<li><p><strong>resource_name</strong> (<em>str</em>) – The name of the resource.</p></li>
<li><p><strong>opts</strong> (<a class="reference internal" href="../pulumi/#pulumi.ResourceOptions" title="pulumi.ResourceOptions"><em>pulumi.ResourceOptions</em></a>) – Options for the resource.</p></li>
<li><p><strong>arguments</strong> (<em>pulumi.Input</em><em>[</em><em>dict</em><em>]</em>) – Additional key/value arguments for the binding.</p></li>
<li><p><strong>destination</strong> (<em>pulumi.Input</em><em>[</em><em>str</em><em>]</em>) – The destination queue or exchange.</p></li>
<li><p><strong>destination_type</strong> (<em>pulumi.Input</em><em>[</em><em>str</em><em>]</em>) – The type of destination (queue or exchange).</p></li>
<li><p><strong>routing_key</strong> (<em>pulumi.Input</em><em>[</em><em>str</em><em>]</em>) – A routing key for the binding.</p></li>
<li><p><strong>source</strong> (<em>pulumi.Input</em><em>[</em><em>str</em><em>]</em>) – The source exchange.</p></li>
<li><p><strong>vhost</strong> (<em>pulumi.Input</em><em>[</em><em>str</em><em>]</em>) – The vhost to create the resource in.</p></li>
</ul>
</dd>
</dl>
<dl class="py attribute">
<dt id="pulumi_rabbitmq.Binding.arguments">
<code class="sig-name descname">arguments</code><em class="property">: pulumi.Output[dict]</em><em class="property"> = None</em><a class="headerlink" href="#pulumi_rabbitmq.Binding.arguments" title="Permalink to this definition">¶</a></dt>
<dd><p>Additional key/value arguments for the binding.</p>
</dd></dl>

<dl class="py attribute">
<dt id="pulumi_rabbitmq.Binding.destination">
<code class="sig-name descname">destination</code><em class="property">: pulumi.Output[str]</em><em class="property"> = None</em><a class="headerlink" href="#pulumi_rabbitmq.Binding.destination" title="Permalink to this definition">¶</a></dt>
<dd><p>The destination queue or exchange.</p>
</dd></dl>

<dl class="py attribute">
<dt id="pulumi_rabbitmq.Binding.destination_type">
<code class="sig-name descname">destination_type</code><em class="property">: pulumi.Output[str]</em><em class="property"> = None</em><a class="headerlink" href="#pulumi_rabbitmq.Binding.destination_type" title="Permalink to this definition">¶</a></dt>
<dd><p>The type of destination (queue or exchange).</p>
</dd></dl>

<dl class="py attribute">
<dt id="pulumi_rabbitmq.Binding.properties_key">
<code class="sig-name descname">properties_key</code><em class="property">: pulumi.Output[str]</em><em class="property"> = None</em><a class="headerlink" href="#pulumi_rabbitmq.Binding.properties_key" title="Permalink to this definition">¶</a></dt>
<dd><p>A unique key to refer to the binding.</p>
</dd></dl>

<dl class="py attribute">
<dt id="pulumi_rabbitmq.Binding.routing_key">
<code class="sig-name descname">routing_key</code><em class="property">: pulumi.Output[str]</em><em class="property"> = None</em><a class="headerlink" href="#pulumi_rabbitmq.Binding.routing_key" title="Permalink to this definition">¶</a></dt>
<dd><p>A routing key for the binding.</p>
</dd></dl>

<dl class="py attribute">
<dt id="pulumi_rabbitmq.Binding.source">
<code class="sig-name descname">source</code><em class="property">: pulumi.Output[str]</em><em class="property"> = None</em><a class="headerlink" href="#pulumi_rabbitmq.Binding.source" title="Permalink to this definition">¶</a></dt>
<dd><p>The source exchange.</p>
</dd></dl>

<dl class="py attribute">
<dt id="pulumi_rabbitmq.Binding.vhost">
<code class="sig-name descname">vhost</code><em class="property">: pulumi.Output[str]</em><em class="property"> = None</em><a class="headerlink" href="#pulumi_rabbitmq.Binding.vhost" title="Permalink to this definition">¶</a></dt>
<dd><p>The vhost to create the resource in.</p>
</dd></dl>

<dl class="py method">
<dt id="pulumi_rabbitmq.Binding.get">
<em class="property">static </em><code class="sig-name descname">get</code><span class="sig-paren">(</span><em class="sig-param"><span class="n">resource_name</span></em>, <em class="sig-param"><span class="n">id</span></em>, <em class="sig-param"><span class="n">opts</span><span class="o">=</span><span class="default_value">None</span></em>, <em class="sig-param"><span class="n">arguments</span><span class="o">=</span><span class="default_value">None</span></em>, <em class="sig-param"><span class="n">arguments_json</span><span class="o">=</span><span class="default_value">None</span></em>, <em class="sig-param"><span class="n">destination</span><span class="o">=</span><span class="default_value">None</span></em>, <em class="sig-param"><span class="n">destination_type</span><span class="o">=</span><span class="default_value">None</span></em>, <em class="sig-param"><span class="n">properties_key</span><span class="o">=</span><span class="default_value">None</span></em>, <em class="sig-param"><span class="n">routing_key</span><span class="o">=</span><span class="default_value">None</span></em>, <em class="sig-param"><span class="n">source</span><span class="o">=</span><span class="default_value">None</span></em>, <em class="sig-param"><span class="n">vhost</span><span class="o">=</span><span class="default_value">None</span></em><span class="sig-paren">)</span><a class="headerlink" href="#pulumi_rabbitmq.Binding.get" title="Permalink to this definition">¶</a></dt>
<dd><p>Get an existing Binding resource’s state with the given name, id, and optional extra
properties used to qualify the lookup.</p>
<dl class="field-list simple">
<dt class="field-odd">Parameters</dt>
<dd class="field-odd"><ul class="simple">
<li><p><strong>resource_name</strong> (<em>str</em>) – The unique name of the resulting resource.</p></li>
<li><p><strong>id</strong> (<em>str</em>) – The unique provider ID of the resource to lookup.</p></li>
<li><p><strong>opts</strong> (<a class="reference internal" href="../pulumi/#pulumi.ResourceOptions" title="pulumi.ResourceOptions"><em>pulumi.ResourceOptions</em></a>) – Options for the resource.</p></li>
<li><p><strong>arguments</strong> (<em>pulumi.Input</em><em>[</em><em>dict</em><em>]</em>) – Additional key/value arguments for the binding.</p></li>
<li><p><strong>destination</strong> (<em>pulumi.Input</em><em>[</em><em>str</em><em>]</em>) – The destination queue or exchange.</p></li>
<li><p><strong>destination_type</strong> (<em>pulumi.Input</em><em>[</em><em>str</em><em>]</em>) – The type of destination (queue or exchange).</p></li>
<li><p><strong>properties_key</strong> (<em>pulumi.Input</em><em>[</em><em>str</em><em>]</em>) – A unique key to refer to the binding.</p></li>
<li><p><strong>routing_key</strong> (<em>pulumi.Input</em><em>[</em><em>str</em><em>]</em>) – A routing key for the binding.</p></li>
<li><p><strong>source</strong> (<em>pulumi.Input</em><em>[</em><em>str</em><em>]</em>) – The source exchange.</p></li>
<li><p><strong>vhost</strong> (<em>pulumi.Input</em><em>[</em><em>str</em><em>]</em>) – The vhost to create the resource in.</p></li>
</ul>
</dd>
</dl>
</dd></dl>

<dl class="py method">
<dt id="pulumi_rabbitmq.Binding.translate_output_property">
<code class="sig-name descname">translate_output_property</code><span class="sig-paren">(</span><em class="sig-param"><span class="n">prop</span></em><span class="sig-paren">)</span><a class="headerlink" href="#pulumi_rabbitmq.Binding.translate_output_property" title="Permalink to this definition">¶</a></dt>
<dd><p>Provides subclasses of Resource an opportunity to translate names of output properties
into a format of their choosing before writing those properties to the resource object.</p>
<dl class="field-list simple">
<dt class="field-odd">Parameters</dt>
<dd class="field-odd"><p><strong>prop</strong> (<em>str</em>) – A property name.</p>
</dd>
<dt class="field-even">Returns</dt>
<dd class="field-even"><p>A potentially transformed property name.</p>
</dd>
<dt class="field-odd">Return type</dt>
<dd class="field-odd"><p>str</p>
</dd>
</dl>
</dd></dl>

<dl class="py method">
<dt id="pulumi_rabbitmq.Binding.translate_input_property">
<code class="sig-name descname">translate_input_property</code><span class="sig-paren">(</span><em class="sig-param"><span class="n">prop</span></em><span class="sig-paren">)</span><a class="headerlink" href="#pulumi_rabbitmq.Binding.translate_input_property" title="Permalink to this definition">¶</a></dt>
<dd><p>Provides subclasses of Resource an opportunity to translate names of input properties into
a format of their choosing before sending those properties to the Pulumi engine.</p>
<dl class="field-list simple">
<dt class="field-odd">Parameters</dt>
<dd class="field-odd"><p><strong>prop</strong> (<em>str</em>) – A property name.</p>
</dd>
<dt class="field-even">Returns</dt>
<dd class="field-even"><p>A potentially transformed property name.</p>
</dd>
<dt class="field-odd">Return type</dt>
<dd class="field-odd"><p>str</p>
</dd>
</dl>
</dd></dl>

</dd></dl>

<dl class="py class">
<dt id="pulumi_rabbitmq.Exchange">
<em class="property">class </em><code class="sig-prename descclassname">pulumi_rabbitmq.</code><code class="sig-name descname">Exchange</code><span class="sig-paren">(</span><em class="sig-param"><span class="n">resource_name</span></em>, <em class="sig-param"><span class="n">opts</span><span class="o">=</span><span class="default_value">None</span></em>, <em class="sig-param"><span class="n">name</span><span class="o">=</span><span class="default_value">None</span></em>, <em class="sig-param"><span class="n">settings</span><span class="o">=</span><span class="default_value">None</span></em>, <em class="sig-param"><span class="n">vhost</span><span class="o">=</span><span class="default_value">None</span></em>, <em class="sig-param"><span class="n">__props__</span><span class="o">=</span><span class="default_value">None</span></em>, <em class="sig-param"><span class="n">__name__</span><span class="o">=</span><span class="default_value">None</span></em>, <em class="sig-param"><span class="n">__opts__</span><span class="o">=</span><span class="default_value">None</span></em><span class="sig-paren">)</span><a class="headerlink" href="#pulumi_rabbitmq.Exchange" title="Permalink to this definition">¶</a></dt>
<dd><p>The <code class="docutils literal notranslate"><span class="pre">Exchange</span></code> resource creates and manages an exchange.</p>
<div class="highlight-python notranslate"><div class="highlight"><pre><span></span><span class="kn">import</span> <span class="nn">pulumi</span>
<span class="kn">import</span> <span class="nn">pulumi_rabbitmq</span> <span class="k">as</span> <span class="nn">rabbitmq</span>

<span class="n">test_v_host</span> <span class="o">=</span> <span class="n">rabbitmq</span><span class="o">.</span><span class="n">VHost</span><span class="p">(</span><span class="s2">&quot;testVHost&quot;</span><span class="p">)</span>
<span class="n">guest</span> <span class="o">=</span> <span class="n">rabbitmq</span><span class="o">.</span><span class="n">Permissions</span><span class="p">(</span><span class="s2">&quot;guest&quot;</span><span class="p">,</span>
    <span class="n">permissions</span><span class="o">=</span><span class="p">{</span>
        <span class="s2">&quot;configure&quot;</span><span class="p">:</span> <span class="s2">&quot;.*&quot;</span><span class="p">,</span>
        <span class="s2">&quot;read&quot;</span><span class="p">:</span> <span class="s2">&quot;.*&quot;</span><span class="p">,</span>
        <span class="s2">&quot;write&quot;</span><span class="p">:</span> <span class="s2">&quot;.*&quot;</span><span class="p">,</span>
    <span class="p">},</span>
    <span class="n">user</span><span class="o">=</span><span class="s2">&quot;guest&quot;</span><span class="p">,</span>
    <span class="n">vhost</span><span class="o">=</span><span class="n">test_v_host</span><span class="o">.</span><span class="n">name</span><span class="p">)</span>
<span class="n">test_exchange</span> <span class="o">=</span> <span class="n">rabbitmq</span><span class="o">.</span><span class="n">Exchange</span><span class="p">(</span><span class="s2">&quot;testExchange&quot;</span><span class="p">,</span>
    <span class="n">settings</span><span class="o">=</span><span class="p">{</span>
        <span class="s2">&quot;autoDelete&quot;</span><span class="p">:</span> <span class="kc">True</span><span class="p">,</span>
        <span class="s2">&quot;durable&quot;</span><span class="p">:</span> <span class="kc">False</span><span class="p">,</span>
        <span class="s2">&quot;type&quot;</span><span class="p">:</span> <span class="s2">&quot;fanout&quot;</span><span class="p">,</span>
    <span class="p">},</span>
    <span class="n">vhost</span><span class="o">=</span><span class="n">guest</span><span class="o">.</span><span class="n">vhost</span><span class="p">)</span>
</pre></div>
</div>
<dl class="field-list simple">
<dt class="field-odd">Parameters</dt>
<dd class="field-odd"><ul class="simple">
<li><p><strong>resource_name</strong> (<em>str</em>) – The name of the resource.</p></li>
<li><p><strong>opts</strong> (<a class="reference internal" href="../pulumi/#pulumi.ResourceOptions" title="pulumi.ResourceOptions"><em>pulumi.ResourceOptions</em></a>) – Options for the resource.</p></li>
<li><p><strong>name</strong> (<em>pulumi.Input</em><em>[</em><em>str</em><em>]</em>) – The name of the exchange.</p></li>
<li><p><strong>settings</strong> (<em>pulumi.Input</em><em>[</em><em>dict</em><em>]</em>) – The settings of the exchange. The structure is
described below.</p></li>
<li><p><strong>vhost</strong> (<em>pulumi.Input</em><em>[</em><em>str</em><em>]</em>) – The vhost to create the resource in.</p></li>
</ul>
</dd>
</dl>
<p>The <strong>settings</strong> object supports the following:</p>
<ul class="simple">
<li><p><code class="docutils literal notranslate"><span class="pre">arguments</span></code> (<code class="docutils literal notranslate"><span class="pre">pulumi.Input[dict]</span></code>) - Additional key/value settings for the exchange.</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">autoDelete</span></code> (<code class="docutils literal notranslate"><span class="pre">pulumi.Input[bool]</span></code>) - Whether the exchange will self-delete when all
queues have finished using it.</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">durable</span></code> (<code class="docutils literal notranslate"><span class="pre">pulumi.Input[bool]</span></code>) - Whether the exchange survives server restarts.
Defaults to <code class="docutils literal notranslate"><span class="pre">false</span></code>.</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">type</span></code> (<code class="docutils literal notranslate"><span class="pre">pulumi.Input[str]</span></code>) - The type of exchange.</p></li>
</ul>
<dl class="py attribute">
<dt id="pulumi_rabbitmq.Exchange.name">
<code class="sig-name descname">name</code><em class="property">: pulumi.Output[str]</em><em class="property"> = None</em><a class="headerlink" href="#pulumi_rabbitmq.Exchange.name" title="Permalink to this definition">¶</a></dt>
<dd><p>The name of the exchange.</p>
</dd></dl>

<dl class="py attribute">
<dt id="pulumi_rabbitmq.Exchange.settings">
<code class="sig-name descname">settings</code><em class="property">: pulumi.Output[dict]</em><em class="property"> = None</em><a class="headerlink" href="#pulumi_rabbitmq.Exchange.settings" title="Permalink to this definition">¶</a></dt>
<dd><p>The settings of the exchange. The structure is
described below.</p>
<ul class="simple">
<li><p><code class="docutils literal notranslate"><span class="pre">arguments</span></code> (<code class="docutils literal notranslate"><span class="pre">dict</span></code>) - Additional key/value settings for the exchange.</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">autoDelete</span></code> (<code class="docutils literal notranslate"><span class="pre">bool</span></code>) - Whether the exchange will self-delete when all
queues have finished using it.</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">durable</span></code> (<code class="docutils literal notranslate"><span class="pre">bool</span></code>) - Whether the exchange survives server restarts.
Defaults to <code class="docutils literal notranslate"><span class="pre">false</span></code>.</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">type</span></code> (<code class="docutils literal notranslate"><span class="pre">str</span></code>) - The type of exchange.</p></li>
</ul>
</dd></dl>

<dl class="py attribute">
<dt id="pulumi_rabbitmq.Exchange.vhost">
<code class="sig-name descname">vhost</code><em class="property">: pulumi.Output[str]</em><em class="property"> = None</em><a class="headerlink" href="#pulumi_rabbitmq.Exchange.vhost" title="Permalink to this definition">¶</a></dt>
<dd><p>The vhost to create the resource in.</p>
</dd></dl>

<dl class="py method">
<dt id="pulumi_rabbitmq.Exchange.get">
<em class="property">static </em><code class="sig-name descname">get</code><span class="sig-paren">(</span><em class="sig-param"><span class="n">resource_name</span></em>, <em class="sig-param"><span class="n">id</span></em>, <em class="sig-param"><span class="n">opts</span><span class="o">=</span><span class="default_value">None</span></em>, <em class="sig-param"><span class="n">name</span><span class="o">=</span><span class="default_value">None</span></em>, <em class="sig-param"><span class="n">settings</span><span class="o">=</span><span class="default_value">None</span></em>, <em class="sig-param"><span class="n">vhost</span><span class="o">=</span><span class="default_value">None</span></em><span class="sig-paren">)</span><a class="headerlink" href="#pulumi_rabbitmq.Exchange.get" title="Permalink to this definition">¶</a></dt>
<dd><p>Get an existing Exchange resource’s state with the given name, id, and optional extra
properties used to qualify the lookup.</p>
<dl class="field-list simple">
<dt class="field-odd">Parameters</dt>
<dd class="field-odd"><ul class="simple">
<li><p><strong>resource_name</strong> (<em>str</em>) – The unique name of the resulting resource.</p></li>
<li><p><strong>id</strong> (<em>str</em>) – The unique provider ID of the resource to lookup.</p></li>
<li><p><strong>opts</strong> (<a class="reference internal" href="../pulumi/#pulumi.ResourceOptions" title="pulumi.ResourceOptions"><em>pulumi.ResourceOptions</em></a>) – Options for the resource.</p></li>
<li><p><strong>name</strong> (<em>pulumi.Input</em><em>[</em><em>str</em><em>]</em>) – The name of the exchange.</p></li>
<li><p><strong>settings</strong> (<em>pulumi.Input</em><em>[</em><em>dict</em><em>]</em>) – The settings of the exchange. The structure is
described below.</p></li>
<li><p><strong>vhost</strong> (<em>pulumi.Input</em><em>[</em><em>str</em><em>]</em>) – The vhost to create the resource in.</p></li>
</ul>
</dd>
</dl>
<p>The <strong>settings</strong> object supports the following:</p>
<ul class="simple">
<li><p><code class="docutils literal notranslate"><span class="pre">arguments</span></code> (<code class="docutils literal notranslate"><span class="pre">pulumi.Input[dict]</span></code>) - Additional key/value settings for the exchange.</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">autoDelete</span></code> (<code class="docutils literal notranslate"><span class="pre">pulumi.Input[bool]</span></code>) - Whether the exchange will self-delete when all
queues have finished using it.</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">durable</span></code> (<code class="docutils literal notranslate"><span class="pre">pulumi.Input[bool]</span></code>) - Whether the exchange survives server restarts.
Defaults to <code class="docutils literal notranslate"><span class="pre">false</span></code>.</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">type</span></code> (<code class="docutils literal notranslate"><span class="pre">pulumi.Input[str]</span></code>) - The type of exchange.</p></li>
</ul>
</dd></dl>

<dl class="py method">
<dt id="pulumi_rabbitmq.Exchange.translate_output_property">
<code class="sig-name descname">translate_output_property</code><span class="sig-paren">(</span><em class="sig-param"><span class="n">prop</span></em><span class="sig-paren">)</span><a class="headerlink" href="#pulumi_rabbitmq.Exchange.translate_output_property" title="Permalink to this definition">¶</a></dt>
<dd><p>Provides subclasses of Resource an opportunity to translate names of output properties
into a format of their choosing before writing those properties to the resource object.</p>
<dl class="field-list simple">
<dt class="field-odd">Parameters</dt>
<dd class="field-odd"><p><strong>prop</strong> (<em>str</em>) – A property name.</p>
</dd>
<dt class="field-even">Returns</dt>
<dd class="field-even"><p>A potentially transformed property name.</p>
</dd>
<dt class="field-odd">Return type</dt>
<dd class="field-odd"><p>str</p>
</dd>
</dl>
</dd></dl>

<dl class="py method">
<dt id="pulumi_rabbitmq.Exchange.translate_input_property">
<code class="sig-name descname">translate_input_property</code><span class="sig-paren">(</span><em class="sig-param"><span class="n">prop</span></em><span class="sig-paren">)</span><a class="headerlink" href="#pulumi_rabbitmq.Exchange.translate_input_property" title="Permalink to this definition">¶</a></dt>
<dd><p>Provides subclasses of Resource an opportunity to translate names of input properties into
a format of their choosing before sending those properties to the Pulumi engine.</p>
<dl class="field-list simple">
<dt class="field-odd">Parameters</dt>
<dd class="field-odd"><p><strong>prop</strong> (<em>str</em>) – A property name.</p>
</dd>
<dt class="field-even">Returns</dt>
<dd class="field-even"><p>A potentially transformed property name.</p>
</dd>
<dt class="field-odd">Return type</dt>
<dd class="field-odd"><p>str</p>
</dd>
</dl>
</dd></dl>

</dd></dl>

<dl class="py class">
<dt id="pulumi_rabbitmq.FederationUpstream">
<em class="property">class </em><code class="sig-prename descclassname">pulumi_rabbitmq.</code><code class="sig-name descname">FederationUpstream</code><span class="sig-paren">(</span><em class="sig-param"><span class="n">resource_name</span></em>, <em class="sig-param"><span class="n">opts</span><span class="o">=</span><span class="default_value">None</span></em>, <em class="sig-param"><span class="n">definition</span><span class="o">=</span><span class="default_value">None</span></em>, <em class="sig-param"><span class="n">name</span><span class="o">=</span><span class="default_value">None</span></em>, <em class="sig-param"><span class="n">vhost</span><span class="o">=</span><span class="default_value">None</span></em>, <em class="sig-param"><span class="n">__props__</span><span class="o">=</span><span class="default_value">None</span></em>, <em class="sig-param"><span class="n">__name__</span><span class="o">=</span><span class="default_value">None</span></em>, <em class="sig-param"><span class="n">__opts__</span><span class="o">=</span><span class="default_value">None</span></em><span class="sig-paren">)</span><a class="headerlink" href="#pulumi_rabbitmq.FederationUpstream" title="Permalink to this definition">¶</a></dt>
<dd><p>Create a FederationUpstream resource with the given unique name, props, and options.
:param str resource_name: The name of the resource.
:param pulumi.ResourceOptions opts: Options for the resource.</p>
<p>The <strong>definition</strong> object supports the following:</p>
<ul class="simple">
<li><p><code class="docutils literal notranslate"><span class="pre">ackMode</span></code> (<code class="docutils literal notranslate"><span class="pre">pulumi.Input[str]</span></code>)</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">exchange</span></code> (<code class="docutils literal notranslate"><span class="pre">pulumi.Input[str]</span></code>)</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">expires</span></code> (<code class="docutils literal notranslate"><span class="pre">pulumi.Input[float]</span></code>)</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">maxHops</span></code> (<code class="docutils literal notranslate"><span class="pre">pulumi.Input[float]</span></code>)</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">messageTtl</span></code> (<code class="docutils literal notranslate"><span class="pre">pulumi.Input[float]</span></code>)</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">prefetchCount</span></code> (<code class="docutils literal notranslate"><span class="pre">pulumi.Input[float]</span></code>)</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">queue</span></code> (<code class="docutils literal notranslate"><span class="pre">pulumi.Input[str]</span></code>)</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">reconnectDelay</span></code> (<code class="docutils literal notranslate"><span class="pre">pulumi.Input[float]</span></code>)</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">trustUserId</span></code> (<code class="docutils literal notranslate"><span class="pre">pulumi.Input[bool]</span></code>)</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">uri</span></code> (<code class="docutils literal notranslate"><span class="pre">pulumi.Input[str]</span></code>)</p></li>
</ul>
<dl class="py method">
<dt id="pulumi_rabbitmq.FederationUpstream.get">
<em class="property">static </em><code class="sig-name descname">get</code><span class="sig-paren">(</span><em class="sig-param"><span class="n">resource_name</span></em>, <em class="sig-param"><span class="n">id</span></em>, <em class="sig-param"><span class="n">opts</span><span class="o">=</span><span class="default_value">None</span></em>, <em class="sig-param"><span class="n">component</span><span class="o">=</span><span class="default_value">None</span></em>, <em class="sig-param"><span class="n">definition</span><span class="o">=</span><span class="default_value">None</span></em>, <em class="sig-param"><span class="n">name</span><span class="o">=</span><span class="default_value">None</span></em>, <em class="sig-param"><span class="n">vhost</span><span class="o">=</span><span class="default_value">None</span></em><span class="sig-paren">)</span><a class="headerlink" href="#pulumi_rabbitmq.FederationUpstream.get" title="Permalink to this definition">¶</a></dt>
<dd><p>Get an existing FederationUpstream resource’s state with the given name, id, and optional extra
properties used to qualify the lookup.</p>
<dl class="field-list simple">
<dt class="field-odd">Parameters</dt>
<dd class="field-odd"><ul class="simple">
<li><p><strong>resource_name</strong> (<em>str</em>) – The unique name of the resulting resource.</p></li>
<li><p><strong>id</strong> (<em>str</em>) – The unique provider ID of the resource to lookup.</p></li>
<li><p><strong>opts</strong> (<a class="reference internal" href="../pulumi/#pulumi.ResourceOptions" title="pulumi.ResourceOptions"><em>pulumi.ResourceOptions</em></a>) – Options for the resource.</p></li>
</ul>
</dd>
</dl>
<p>The <strong>definition</strong> object supports the following:</p>
<ul class="simple">
<li><p><code class="docutils literal notranslate"><span class="pre">ackMode</span></code> (<code class="docutils literal notranslate"><span class="pre">pulumi.Input[str]</span></code>)</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">exchange</span></code> (<code class="docutils literal notranslate"><span class="pre">pulumi.Input[str]</span></code>)</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">expires</span></code> (<code class="docutils literal notranslate"><span class="pre">pulumi.Input[float]</span></code>)</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">maxHops</span></code> (<code class="docutils literal notranslate"><span class="pre">pulumi.Input[float]</span></code>)</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">messageTtl</span></code> (<code class="docutils literal notranslate"><span class="pre">pulumi.Input[float]</span></code>)</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">prefetchCount</span></code> (<code class="docutils literal notranslate"><span class="pre">pulumi.Input[float]</span></code>)</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">queue</span></code> (<code class="docutils literal notranslate"><span class="pre">pulumi.Input[str]</span></code>)</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">reconnectDelay</span></code> (<code class="docutils literal notranslate"><span class="pre">pulumi.Input[float]</span></code>)</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">trustUserId</span></code> (<code class="docutils literal notranslate"><span class="pre">pulumi.Input[bool]</span></code>)</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">uri</span></code> (<code class="docutils literal notranslate"><span class="pre">pulumi.Input[str]</span></code>)</p></li>
</ul>
</dd></dl>

<dl class="py method">
<dt id="pulumi_rabbitmq.FederationUpstream.translate_output_property">
<code class="sig-name descname">translate_output_property</code><span class="sig-paren">(</span><em class="sig-param"><span class="n">prop</span></em><span class="sig-paren">)</span><a class="headerlink" href="#pulumi_rabbitmq.FederationUpstream.translate_output_property" title="Permalink to this definition">¶</a></dt>
<dd><p>Provides subclasses of Resource an opportunity to translate names of output properties
into a format of their choosing before writing those properties to the resource object.</p>
<dl class="field-list simple">
<dt class="field-odd">Parameters</dt>
<dd class="field-odd"><p><strong>prop</strong> (<em>str</em>) – A property name.</p>
</dd>
<dt class="field-even">Returns</dt>
<dd class="field-even"><p>A potentially transformed property name.</p>
</dd>
<dt class="field-odd">Return type</dt>
<dd class="field-odd"><p>str</p>
</dd>
</dl>
</dd></dl>

<dl class="py method">
<dt id="pulumi_rabbitmq.FederationUpstream.translate_input_property">
<code class="sig-name descname">translate_input_property</code><span class="sig-paren">(</span><em class="sig-param"><span class="n">prop</span></em><span class="sig-paren">)</span><a class="headerlink" href="#pulumi_rabbitmq.FederationUpstream.translate_input_property" title="Permalink to this definition">¶</a></dt>
<dd><p>Provides subclasses of Resource an opportunity to translate names of input properties into
a format of their choosing before sending those properties to the Pulumi engine.</p>
<dl class="field-list simple">
<dt class="field-odd">Parameters</dt>
<dd class="field-odd"><p><strong>prop</strong> (<em>str</em>) – A property name.</p>
</dd>
<dt class="field-even">Returns</dt>
<dd class="field-even"><p>A potentially transformed property name.</p>
</dd>
<dt class="field-odd">Return type</dt>
<dd class="field-odd"><p>str</p>
</dd>
</dl>
</dd></dl>

</dd></dl>

<dl class="py class">
<dt id="pulumi_rabbitmq.Permissions">
<em class="property">class </em><code class="sig-prename descclassname">pulumi_rabbitmq.</code><code class="sig-name descname">Permissions</code><span class="sig-paren">(</span><em class="sig-param"><span class="n">resource_name</span></em>, <em class="sig-param"><span class="n">opts</span><span class="o">=</span><span class="default_value">None</span></em>, <em class="sig-param"><span class="n">permissions</span><span class="o">=</span><span class="default_value">None</span></em>, <em class="sig-param"><span class="n">user</span><span class="o">=</span><span class="default_value">None</span></em>, <em class="sig-param"><span class="n">vhost</span><span class="o">=</span><span class="default_value">None</span></em>, <em class="sig-param"><span class="n">__props__</span><span class="o">=</span><span class="default_value">None</span></em>, <em class="sig-param"><span class="n">__name__</span><span class="o">=</span><span class="default_value">None</span></em>, <em class="sig-param"><span class="n">__opts__</span><span class="o">=</span><span class="default_value">None</span></em><span class="sig-paren">)</span><a class="headerlink" href="#pulumi_rabbitmq.Permissions" title="Permalink to this definition">¶</a></dt>
<dd><p>The <code class="docutils literal notranslate"><span class="pre">Permissions</span></code> resource creates and manages a user’s set of
permissions.</p>
<div class="highlight-python notranslate"><div class="highlight"><pre><span></span><span class="kn">import</span> <span class="nn">pulumi</span>
<span class="kn">import</span> <span class="nn">pulumi_rabbitmq</span> <span class="k">as</span> <span class="nn">rabbitmq</span>

<span class="n">test_v_host</span> <span class="o">=</span> <span class="n">rabbitmq</span><span class="o">.</span><span class="n">VHost</span><span class="p">(</span><span class="s2">&quot;testVHost&quot;</span><span class="p">)</span>
<span class="n">test_user</span> <span class="o">=</span> <span class="n">rabbitmq</span><span class="o">.</span><span class="n">User</span><span class="p">(</span><span class="s2">&quot;testUser&quot;</span><span class="p">,</span>
    <span class="n">password</span><span class="o">=</span><span class="s2">&quot;foobar&quot;</span><span class="p">,</span>
    <span class="n">tags</span><span class="o">=</span><span class="p">[</span><span class="s2">&quot;administrator&quot;</span><span class="p">])</span>
<span class="n">test_permissions</span> <span class="o">=</span> <span class="n">rabbitmq</span><span class="o">.</span><span class="n">Permissions</span><span class="p">(</span><span class="s2">&quot;testPermissions&quot;</span><span class="p">,</span>
    <span class="n">permissions</span><span class="o">=</span><span class="p">{</span>
        <span class="s2">&quot;configure&quot;</span><span class="p">:</span> <span class="s2">&quot;.*&quot;</span><span class="p">,</span>
        <span class="s2">&quot;read&quot;</span><span class="p">:</span> <span class="s2">&quot;.*&quot;</span><span class="p">,</span>
        <span class="s2">&quot;write&quot;</span><span class="p">:</span> <span class="s2">&quot;.*&quot;</span><span class="p">,</span>
    <span class="p">},</span>
    <span class="n">user</span><span class="o">=</span><span class="n">test_user</span><span class="o">.</span><span class="n">name</span><span class="p">,</span>
    <span class="n">vhost</span><span class="o">=</span><span class="n">test_v_host</span><span class="o">.</span><span class="n">name</span><span class="p">)</span>
</pre></div>
</div>
<dl class="field-list simple">
<dt class="field-odd">Parameters</dt>
<dd class="field-odd"><ul class="simple">
<li><p><strong>resource_name</strong> (<em>str</em>) – The name of the resource.</p></li>
<li><p><strong>opts</strong> (<a class="reference internal" href="../pulumi/#pulumi.ResourceOptions" title="pulumi.ResourceOptions"><em>pulumi.ResourceOptions</em></a>) – Options for the resource.</p></li>
<li><p><strong>permissions</strong> (<em>pulumi.Input</em><em>[</em><em>dict</em><em>]</em>) – The settings of the permissions. The structure is
described below.</p></li>
<li><p><strong>user</strong> (<em>pulumi.Input</em><em>[</em><em>str</em><em>]</em>) – The user to apply the permissions to.</p></li>
<li><p><strong>vhost</strong> (<em>pulumi.Input</em><em>[</em><em>str</em><em>]</em>) – The vhost to create the resource in.</p></li>
</ul>
</dd>
</dl>
<p>The <strong>permissions</strong> object supports the following:</p>
<ul class="simple">
<li><p><code class="docutils literal notranslate"><span class="pre">configure</span></code> (<code class="docutils literal notranslate"><span class="pre">pulumi.Input[str]</span></code>) - The “configure” ACL.</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">read</span></code> (<code class="docutils literal notranslate"><span class="pre">pulumi.Input[str]</span></code>) - The “read” ACL.</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">write</span></code> (<code class="docutils literal notranslate"><span class="pre">pulumi.Input[str]</span></code>) - The “write” ACL.</p></li>
</ul>
<dl class="py attribute">
<dt id="pulumi_rabbitmq.Permissions.permissions">
<code class="sig-name descname">permissions</code><em class="property">: pulumi.Output[dict]</em><em class="property"> = None</em><a class="headerlink" href="#pulumi_rabbitmq.Permissions.permissions" title="Permalink to this definition">¶</a></dt>
<dd><p>The settings of the permissions. The structure is
described below.</p>
<ul class="simple">
<li><p><code class="docutils literal notranslate"><span class="pre">configure</span></code> (<code class="docutils literal notranslate"><span class="pre">str</span></code>) - The “configure” ACL.</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">read</span></code> (<code class="docutils literal notranslate"><span class="pre">str</span></code>) - The “read” ACL.</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">write</span></code> (<code class="docutils literal notranslate"><span class="pre">str</span></code>) - The “write” ACL.</p></li>
</ul>
</dd></dl>

<dl class="py attribute">
<dt id="pulumi_rabbitmq.Permissions.user">
<code class="sig-name descname">user</code><em class="property">: pulumi.Output[str]</em><em class="property"> = None</em><a class="headerlink" href="#pulumi_rabbitmq.Permissions.user" title="Permalink to this definition">¶</a></dt>
<dd><p>The user to apply the permissions to.</p>
</dd></dl>

<dl class="py attribute">
<dt id="pulumi_rabbitmq.Permissions.vhost">
<code class="sig-name descname">vhost</code><em class="property">: pulumi.Output[str]</em><em class="property"> = None</em><a class="headerlink" href="#pulumi_rabbitmq.Permissions.vhost" title="Permalink to this definition">¶</a></dt>
<dd><p>The vhost to create the resource in.</p>
</dd></dl>

<dl class="py method">
<dt id="pulumi_rabbitmq.Permissions.get">
<em class="property">static </em><code class="sig-name descname">get</code><span class="sig-paren">(</span><em class="sig-param"><span class="n">resource_name</span></em>, <em class="sig-param"><span class="n">id</span></em>, <em class="sig-param"><span class="n">opts</span><span class="o">=</span><span class="default_value">None</span></em>, <em class="sig-param"><span class="n">permissions</span><span class="o">=</span><span class="default_value">None</span></em>, <em class="sig-param"><span class="n">user</span><span class="o">=</span><span class="default_value">None</span></em>, <em class="sig-param"><span class="n">vhost</span><span class="o">=</span><span class="default_value">None</span></em><span class="sig-paren">)</span><a class="headerlink" href="#pulumi_rabbitmq.Permissions.get" title="Permalink to this definition">¶</a></dt>
<dd><p>Get an existing Permissions resource’s state with the given name, id, and optional extra
properties used to qualify the lookup.</p>
<dl class="field-list simple">
<dt class="field-odd">Parameters</dt>
<dd class="field-odd"><ul class="simple">
<li><p><strong>resource_name</strong> (<em>str</em>) – The unique name of the resulting resource.</p></li>
<li><p><strong>id</strong> (<em>str</em>) – The unique provider ID of the resource to lookup.</p></li>
<li><p><strong>opts</strong> (<a class="reference internal" href="../pulumi/#pulumi.ResourceOptions" title="pulumi.ResourceOptions"><em>pulumi.ResourceOptions</em></a>) – Options for the resource.</p></li>
<li><p><strong>permissions</strong> (<em>pulumi.Input</em><em>[</em><em>dict</em><em>]</em>) – The settings of the permissions. The structure is
described below.</p></li>
<li><p><strong>user</strong> (<em>pulumi.Input</em><em>[</em><em>str</em><em>]</em>) – The user to apply the permissions to.</p></li>
<li><p><strong>vhost</strong> (<em>pulumi.Input</em><em>[</em><em>str</em><em>]</em>) – The vhost to create the resource in.</p></li>
</ul>
</dd>
</dl>
<p>The <strong>permissions</strong> object supports the following:</p>
<ul class="simple">
<li><p><code class="docutils literal notranslate"><span class="pre">configure</span></code> (<code class="docutils literal notranslate"><span class="pre">pulumi.Input[str]</span></code>) - The “configure” ACL.</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">read</span></code> (<code class="docutils literal notranslate"><span class="pre">pulumi.Input[str]</span></code>) - The “read” ACL.</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">write</span></code> (<code class="docutils literal notranslate"><span class="pre">pulumi.Input[str]</span></code>) - The “write” ACL.</p></li>
</ul>
</dd></dl>

<dl class="py method">
<dt id="pulumi_rabbitmq.Permissions.translate_output_property">
<code class="sig-name descname">translate_output_property</code><span class="sig-paren">(</span><em class="sig-param"><span class="n">prop</span></em><span class="sig-paren">)</span><a class="headerlink" href="#pulumi_rabbitmq.Permissions.translate_output_property" title="Permalink to this definition">¶</a></dt>
<dd><p>Provides subclasses of Resource an opportunity to translate names of output properties
into a format of their choosing before writing those properties to the resource object.</p>
<dl class="field-list simple">
<dt class="field-odd">Parameters</dt>
<dd class="field-odd"><p><strong>prop</strong> (<em>str</em>) – A property name.</p>
</dd>
<dt class="field-even">Returns</dt>
<dd class="field-even"><p>A potentially transformed property name.</p>
</dd>
<dt class="field-odd">Return type</dt>
<dd class="field-odd"><p>str</p>
</dd>
</dl>
</dd></dl>

<dl class="py method">
<dt id="pulumi_rabbitmq.Permissions.translate_input_property">
<code class="sig-name descname">translate_input_property</code><span class="sig-paren">(</span><em class="sig-param"><span class="n">prop</span></em><span class="sig-paren">)</span><a class="headerlink" href="#pulumi_rabbitmq.Permissions.translate_input_property" title="Permalink to this definition">¶</a></dt>
<dd><p>Provides subclasses of Resource an opportunity to translate names of input properties into
a format of their choosing before sending those properties to the Pulumi engine.</p>
<dl class="field-list simple">
<dt class="field-odd">Parameters</dt>
<dd class="field-odd"><p><strong>prop</strong> (<em>str</em>) – A property name.</p>
</dd>
<dt class="field-even">Returns</dt>
<dd class="field-even"><p>A potentially transformed property name.</p>
</dd>
<dt class="field-odd">Return type</dt>
<dd class="field-odd"><p>str</p>
</dd>
</dl>
</dd></dl>

</dd></dl>

<dl class="py class">
<dt id="pulumi_rabbitmq.Policy">
<em class="property">class </em><code class="sig-prename descclassname">pulumi_rabbitmq.</code><code class="sig-name descname">Policy</code><span class="sig-paren">(</span><em class="sig-param"><span class="n">resource_name</span></em>, <em class="sig-param"><span class="n">opts</span><span class="o">=</span><span class="default_value">None</span></em>, <em class="sig-param"><span class="n">name</span><span class="o">=</span><span class="default_value">None</span></em>, <em class="sig-param"><span class="n">policy</span><span class="o">=</span><span class="default_value">None</span></em>, <em class="sig-param"><span class="n">vhost</span><span class="o">=</span><span class="default_value">None</span></em>, <em class="sig-param"><span class="n">__props__</span><span class="o">=</span><span class="default_value">None</span></em>, <em class="sig-param"><span class="n">__name__</span><span class="o">=</span><span class="default_value">None</span></em>, <em class="sig-param"><span class="n">__opts__</span><span class="o">=</span><span class="default_value">None</span></em><span class="sig-paren">)</span><a class="headerlink" href="#pulumi_rabbitmq.Policy" title="Permalink to this definition">¶</a></dt>
<dd><p>The <code class="docutils literal notranslate"><span class="pre">Policy</span></code> resource creates and manages policies for exchanges
and queues.</p>
<div class="highlight-python notranslate"><div class="highlight"><pre><span></span><span class="kn">import</span> <span class="nn">pulumi</span>
<span class="kn">import</span> <span class="nn">pulumi_rabbitmq</span> <span class="k">as</span> <span class="nn">rabbitmq</span>

<span class="n">test_v_host</span> <span class="o">=</span> <span class="n">rabbitmq</span><span class="o">.</span><span class="n">VHost</span><span class="p">(</span><span class="s2">&quot;testVHost&quot;</span><span class="p">)</span>
<span class="n">guest</span> <span class="o">=</span> <span class="n">rabbitmq</span><span class="o">.</span><span class="n">Permissions</span><span class="p">(</span><span class="s2">&quot;guest&quot;</span><span class="p">,</span>
    <span class="n">permissions</span><span class="o">=</span><span class="p">{</span>
        <span class="s2">&quot;configure&quot;</span><span class="p">:</span> <span class="s2">&quot;.*&quot;</span><span class="p">,</span>
        <span class="s2">&quot;read&quot;</span><span class="p">:</span> <span class="s2">&quot;.*&quot;</span><span class="p">,</span>
        <span class="s2">&quot;write&quot;</span><span class="p">:</span> <span class="s2">&quot;.*&quot;</span><span class="p">,</span>
    <span class="p">},</span>
    <span class="n">user</span><span class="o">=</span><span class="s2">&quot;guest&quot;</span><span class="p">,</span>
    <span class="n">vhost</span><span class="o">=</span><span class="n">test_v_host</span><span class="o">.</span><span class="n">name</span><span class="p">)</span>
<span class="n">test_policy</span> <span class="o">=</span> <span class="n">rabbitmq</span><span class="o">.</span><span class="n">Policy</span><span class="p">(</span><span class="s2">&quot;testPolicy&quot;</span><span class="p">,</span>
    <span class="n">policy</span><span class="o">=</span><span class="p">{</span>
        <span class="s2">&quot;applyTo&quot;</span><span class="p">:</span> <span class="s2">&quot;all&quot;</span><span class="p">,</span>
        <span class="s2">&quot;definition&quot;</span><span class="p">:</span> <span class="p">{</span>
            <span class="s2">&quot;ha-mode&quot;</span><span class="p">:</span> <span class="s2">&quot;all&quot;</span><span class="p">,</span>
        <span class="p">},</span>
        <span class="s2">&quot;pattern&quot;</span><span class="p">:</span> <span class="s2">&quot;.*&quot;</span><span class="p">,</span>
        <span class="s2">&quot;priority&quot;</span><span class="p">:</span> <span class="mi">0</span><span class="p">,</span>
    <span class="p">},</span>
    <span class="n">vhost</span><span class="o">=</span><span class="n">guest</span><span class="o">.</span><span class="n">vhost</span><span class="p">)</span>
</pre></div>
</div>
<dl class="field-list simple">
<dt class="field-odd">Parameters</dt>
<dd class="field-odd"><ul class="simple">
<li><p><strong>resource_name</strong> (<em>str</em>) – The name of the resource.</p></li>
<li><p><strong>opts</strong> (<a class="reference internal" href="../pulumi/#pulumi.ResourceOptions" title="pulumi.ResourceOptions"><em>pulumi.ResourceOptions</em></a>) – Options for the resource.</p></li>
<li><p><strong>name</strong> (<em>pulumi.Input</em><em>[</em><em>str</em><em>]</em>) – The name of the policy.</p></li>
<li><p><strong>policy</strong> (<em>pulumi.Input</em><em>[</em><em>dict</em><em>]</em>) – The settings of the policy. The structure is
described below.</p></li>
<li><p><strong>vhost</strong> (<em>pulumi.Input</em><em>[</em><em>str</em><em>]</em>) – The vhost to create the resource in.</p></li>
</ul>
</dd>
</dl>
<p>The <strong>policy</strong> object supports the following:</p>
<ul class="simple">
<li><p><code class="docutils literal notranslate"><span class="pre">applyTo</span></code> (<code class="docutils literal notranslate"><span class="pre">pulumi.Input[str]</span></code>) - Can either be “exchanges”, “queues”, or “all”.</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">definition</span></code> (<code class="docutils literal notranslate"><span class="pre">pulumi.Input[dict]</span></code>) - Key/value pairs of the policy definition. See the
RabbitMQ documentation for definition references and examples.</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">pattern</span></code> (<code class="docutils literal notranslate"><span class="pre">pulumi.Input[str]</span></code>) - A pattern to match an exchange or queue name.</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">priority</span></code> (<code class="docutils literal notranslate"><span class="pre">pulumi.Input[float]</span></code>) - The policy with the greater priority is applied first.</p></li>
</ul>
<dl class="py attribute">
<dt id="pulumi_rabbitmq.Policy.name">
<code class="sig-name descname">name</code><em class="property">: pulumi.Output[str]</em><em class="property"> = None</em><a class="headerlink" href="#pulumi_rabbitmq.Policy.name" title="Permalink to this definition">¶</a></dt>
<dd><p>The name of the policy.</p>
</dd></dl>

<dl class="py attribute">
<dt id="pulumi_rabbitmq.Policy.policy">
<code class="sig-name descname">policy</code><em class="property">: pulumi.Output[dict]</em><em class="property"> = None</em><a class="headerlink" href="#pulumi_rabbitmq.Policy.policy" title="Permalink to this definition">¶</a></dt>
<dd><p>The settings of the policy. The structure is
described below.</p>
<ul class="simple">
<li><p><code class="docutils literal notranslate"><span class="pre">applyTo</span></code> (<code class="docutils literal notranslate"><span class="pre">str</span></code>) - Can either be “exchanges”, “queues”, or “all”.</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">definition</span></code> (<code class="docutils literal notranslate"><span class="pre">dict</span></code>) - Key/value pairs of the policy definition. See the
RabbitMQ documentation for definition references and examples.</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">pattern</span></code> (<code class="docutils literal notranslate"><span class="pre">str</span></code>) - A pattern to match an exchange or queue name.</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">priority</span></code> (<code class="docutils literal notranslate"><span class="pre">float</span></code>) - The policy with the greater priority is applied first.</p></li>
</ul>
</dd></dl>

<dl class="py attribute">
<dt id="pulumi_rabbitmq.Policy.vhost">
<code class="sig-name descname">vhost</code><em class="property">: pulumi.Output[str]</em><em class="property"> = None</em><a class="headerlink" href="#pulumi_rabbitmq.Policy.vhost" title="Permalink to this definition">¶</a></dt>
<dd><p>The vhost to create the resource in.</p>
</dd></dl>

<dl class="py method">
<dt id="pulumi_rabbitmq.Policy.get">
<em class="property">static </em><code class="sig-name descname">get</code><span class="sig-paren">(</span><em class="sig-param"><span class="n">resource_name</span></em>, <em class="sig-param"><span class="n">id</span></em>, <em class="sig-param"><span class="n">opts</span><span class="o">=</span><span class="default_value">None</span></em>, <em class="sig-param"><span class="n">name</span><span class="o">=</span><span class="default_value">None</span></em>, <em class="sig-param"><span class="n">policy</span><span class="o">=</span><span class="default_value">None</span></em>, <em class="sig-param"><span class="n">vhost</span><span class="o">=</span><span class="default_value">None</span></em><span class="sig-paren">)</span><a class="headerlink" href="#pulumi_rabbitmq.Policy.get" title="Permalink to this definition">¶</a></dt>
<dd><p>Get an existing Policy resource’s state with the given name, id, and optional extra
properties used to qualify the lookup.</p>
<dl class="field-list simple">
<dt class="field-odd">Parameters</dt>
<dd class="field-odd"><ul class="simple">
<li><p><strong>resource_name</strong> (<em>str</em>) – The unique name of the resulting resource.</p></li>
<li><p><strong>id</strong> (<em>str</em>) – The unique provider ID of the resource to lookup.</p></li>
<li><p><strong>opts</strong> (<a class="reference internal" href="../pulumi/#pulumi.ResourceOptions" title="pulumi.ResourceOptions"><em>pulumi.ResourceOptions</em></a>) – Options for the resource.</p></li>
<li><p><strong>name</strong> (<em>pulumi.Input</em><em>[</em><em>str</em><em>]</em>) – The name of the policy.</p></li>
<li><p><strong>policy</strong> (<em>pulumi.Input</em><em>[</em><em>dict</em><em>]</em>) – The settings of the policy. The structure is
described below.</p></li>
<li><p><strong>vhost</strong> (<em>pulumi.Input</em><em>[</em><em>str</em><em>]</em>) – The vhost to create the resource in.</p></li>
</ul>
</dd>
</dl>
<p>The <strong>policy</strong> object supports the following:</p>
<ul class="simple">
<li><p><code class="docutils literal notranslate"><span class="pre">applyTo</span></code> (<code class="docutils literal notranslate"><span class="pre">pulumi.Input[str]</span></code>) - Can either be “exchanges”, “queues”, or “all”.</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">definition</span></code> (<code class="docutils literal notranslate"><span class="pre">pulumi.Input[dict]</span></code>) - Key/value pairs of the policy definition. See the
RabbitMQ documentation for definition references and examples.</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">pattern</span></code> (<code class="docutils literal notranslate"><span class="pre">pulumi.Input[str]</span></code>) - A pattern to match an exchange or queue name.</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">priority</span></code> (<code class="docutils literal notranslate"><span class="pre">pulumi.Input[float]</span></code>) - The policy with the greater priority is applied first.</p></li>
</ul>
</dd></dl>

<dl class="py method">
<dt id="pulumi_rabbitmq.Policy.translate_output_property">
<code class="sig-name descname">translate_output_property</code><span class="sig-paren">(</span><em class="sig-param"><span class="n">prop</span></em><span class="sig-paren">)</span><a class="headerlink" href="#pulumi_rabbitmq.Policy.translate_output_property" title="Permalink to this definition">¶</a></dt>
<dd><p>Provides subclasses of Resource an opportunity to translate names of output properties
into a format of their choosing before writing those properties to the resource object.</p>
<dl class="field-list simple">
<dt class="field-odd">Parameters</dt>
<dd class="field-odd"><p><strong>prop</strong> (<em>str</em>) – A property name.</p>
</dd>
<dt class="field-even">Returns</dt>
<dd class="field-even"><p>A potentially transformed property name.</p>
</dd>
<dt class="field-odd">Return type</dt>
<dd class="field-odd"><p>str</p>
</dd>
</dl>
</dd></dl>

<dl class="py method">
<dt id="pulumi_rabbitmq.Policy.translate_input_property">
<code class="sig-name descname">translate_input_property</code><span class="sig-paren">(</span><em class="sig-param"><span class="n">prop</span></em><span class="sig-paren">)</span><a class="headerlink" href="#pulumi_rabbitmq.Policy.translate_input_property" title="Permalink to this definition">¶</a></dt>
<dd><p>Provides subclasses of Resource an opportunity to translate names of input properties into
a format of their choosing before sending those properties to the Pulumi engine.</p>
<dl class="field-list simple">
<dt class="field-odd">Parameters</dt>
<dd class="field-odd"><p><strong>prop</strong> (<em>str</em>) – A property name.</p>
</dd>
<dt class="field-even">Returns</dt>
<dd class="field-even"><p>A potentially transformed property name.</p>
</dd>
<dt class="field-odd">Return type</dt>
<dd class="field-odd"><p>str</p>
</dd>
</dl>
</dd></dl>

</dd></dl>

<dl class="py class">
<dt id="pulumi_rabbitmq.Provider">
<em class="property">class </em><code class="sig-prename descclassname">pulumi_rabbitmq.</code><code class="sig-name descname">Provider</code><span class="sig-paren">(</span><em class="sig-param"><span class="n">resource_name</span></em>, <em class="sig-param"><span class="n">opts</span><span class="o">=</span><span class="default_value">None</span></em>, <em class="sig-param"><span class="n">cacert_file</span><span class="o">=</span><span class="default_value">None</span></em>, <em class="sig-param"><span class="n">clientcert_file</span><span class="o">=</span><span class="default_value">None</span></em>, <em class="sig-param"><span class="n">clientkey_file</span><span class="o">=</span><span class="default_value">None</span></em>, <em class="sig-param"><span class="n">endpoint</span><span class="o">=</span><span class="default_value">None</span></em>, <em class="sig-param"><span class="n">insecure</span><span class="o">=</span><span class="default_value">None</span></em>, <em class="sig-param"><span class="n">password</span><span class="o">=</span><span class="default_value">None</span></em>, <em class="sig-param"><span class="n">username</span><span class="o">=</span><span class="default_value">None</span></em>, <em class="sig-param"><span class="n">__props__</span><span class="o">=</span><span class="default_value">None</span></em>, <em class="sig-param"><span class="n">__name__</span><span class="o">=</span><span class="default_value">None</span></em>, <em class="sig-param"><span class="n">__opts__</span><span class="o">=</span><span class="default_value">None</span></em><span class="sig-paren">)</span><a class="headerlink" href="#pulumi_rabbitmq.Provider" title="Permalink to this definition">¶</a></dt>
<dd><p>The provider type for the rabbitmq package. By default, resources use package-wide configuration
settings, however an explicit <code class="docutils literal notranslate"><span class="pre">Provider</span></code> instance may be created and passed during resource
construction to achieve fine-grained programmatic control over provider settings. See the
<a class="reference external" href="https://www.pulumi.com/docs/reference/programming-model/#providers">documentation</a> for more information.</p>
<dl class="field-list simple">
<dt class="field-odd">Parameters</dt>
<dd class="field-odd"><ul class="simple">
<li><p><strong>resource_name</strong> (<em>str</em>) – The name of the resource.</p></li>
<li><p><strong>opts</strong> (<a class="reference internal" href="../pulumi/#pulumi.ResourceOptions" title="pulumi.ResourceOptions"><em>pulumi.ResourceOptions</em></a>) – Options for the resource.</p></li>
</ul>
</dd>
</dl>
<dl class="py method">
<dt id="pulumi_rabbitmq.Provider.translate_output_property">
<code class="sig-name descname">translate_output_property</code><span class="sig-paren">(</span><em class="sig-param"><span class="n">prop</span></em><span class="sig-paren">)</span><a class="headerlink" href="#pulumi_rabbitmq.Provider.translate_output_property" title="Permalink to this definition">¶</a></dt>
<dd><p>Provides subclasses of Resource an opportunity to translate names of output properties
into a format of their choosing before writing those properties to the resource object.</p>
<dl class="field-list simple">
<dt class="field-odd">Parameters</dt>
<dd class="field-odd"><p><strong>prop</strong> (<em>str</em>) – A property name.</p>
</dd>
<dt class="field-even">Returns</dt>
<dd class="field-even"><p>A potentially transformed property name.</p>
</dd>
<dt class="field-odd">Return type</dt>
<dd class="field-odd"><p>str</p>
</dd>
</dl>
</dd></dl>

<dl class="py method">
<dt id="pulumi_rabbitmq.Provider.translate_input_property">
<code class="sig-name descname">translate_input_property</code><span class="sig-paren">(</span><em class="sig-param"><span class="n">prop</span></em><span class="sig-paren">)</span><a class="headerlink" href="#pulumi_rabbitmq.Provider.translate_input_property" title="Permalink to this definition">¶</a></dt>
<dd><p>Provides subclasses of Resource an opportunity to translate names of input properties into
a format of their choosing before sending those properties to the Pulumi engine.</p>
<dl class="field-list simple">
<dt class="field-odd">Parameters</dt>
<dd class="field-odd"><p><strong>prop</strong> (<em>str</em>) – A property name.</p>
</dd>
<dt class="field-even">Returns</dt>
<dd class="field-even"><p>A potentially transformed property name.</p>
</dd>
<dt class="field-odd">Return type</dt>
<dd class="field-odd"><p>str</p>
</dd>
</dl>
</dd></dl>

</dd></dl>

<dl class="py class">
<dt id="pulumi_rabbitmq.Queue">
<em class="property">class </em><code class="sig-prename descclassname">pulumi_rabbitmq.</code><code class="sig-name descname">Queue</code><span class="sig-paren">(</span><em class="sig-param"><span class="n">resource_name</span></em>, <em class="sig-param"><span class="n">opts</span><span class="o">=</span><span class="default_value">None</span></em>, <em class="sig-param"><span class="n">name</span><span class="o">=</span><span class="default_value">None</span></em>, <em class="sig-param"><span class="n">settings</span><span class="o">=</span><span class="default_value">None</span></em>, <em class="sig-param"><span class="n">vhost</span><span class="o">=</span><span class="default_value">None</span></em>, <em class="sig-param"><span class="n">__props__</span><span class="o">=</span><span class="default_value">None</span></em>, <em class="sig-param"><span class="n">__name__</span><span class="o">=</span><span class="default_value">None</span></em>, <em class="sig-param"><span class="n">__opts__</span><span class="o">=</span><span class="default_value">None</span></em><span class="sig-paren">)</span><a class="headerlink" href="#pulumi_rabbitmq.Queue" title="Permalink to this definition">¶</a></dt>
<dd><p>The <code class="docutils literal notranslate"><span class="pre">Queue</span></code> resource creates and manages a queue.</p>
<div class="highlight-python notranslate"><div class="highlight"><pre><span></span><span class="kn">import</span> <span class="nn">pulumi</span>
<span class="kn">import</span> <span class="nn">pulumi_rabbitmq</span> <span class="k">as</span> <span class="nn">rabbitmq</span>

<span class="n">test_v_host</span> <span class="o">=</span> <span class="n">rabbitmq</span><span class="o">.</span><span class="n">VHost</span><span class="p">(</span><span class="s2">&quot;testVHost&quot;</span><span class="p">)</span>
<span class="n">guest</span> <span class="o">=</span> <span class="n">rabbitmq</span><span class="o">.</span><span class="n">Permissions</span><span class="p">(</span><span class="s2">&quot;guest&quot;</span><span class="p">,</span>
    <span class="n">permissions</span><span class="o">=</span><span class="p">{</span>
        <span class="s2">&quot;configure&quot;</span><span class="p">:</span> <span class="s2">&quot;.*&quot;</span><span class="p">,</span>
        <span class="s2">&quot;read&quot;</span><span class="p">:</span> <span class="s2">&quot;.*&quot;</span><span class="p">,</span>
        <span class="s2">&quot;write&quot;</span><span class="p">:</span> <span class="s2">&quot;.*&quot;</span><span class="p">,</span>
    <span class="p">},</span>
    <span class="n">user</span><span class="o">=</span><span class="s2">&quot;guest&quot;</span><span class="p">,</span>
    <span class="n">vhost</span><span class="o">=</span><span class="n">test_v_host</span><span class="o">.</span><span class="n">name</span><span class="p">)</span>
<span class="n">test_queue</span> <span class="o">=</span> <span class="n">rabbitmq</span><span class="o">.</span><span class="n">Queue</span><span class="p">(</span><span class="s2">&quot;testQueue&quot;</span><span class="p">,</span>
    <span class="n">settings</span><span class="o">=</span><span class="p">{</span>
        <span class="s2">&quot;autoDelete&quot;</span><span class="p">:</span> <span class="kc">True</span><span class="p">,</span>
        <span class="s2">&quot;durable&quot;</span><span class="p">:</span> <span class="kc">False</span><span class="p">,</span>
    <span class="p">},</span>
    <span class="n">vhost</span><span class="o">=</span><span class="n">guest</span><span class="o">.</span><span class="n">vhost</span><span class="p">)</span>
</pre></div>
</div>
<div class="highlight-python notranslate"><div class="highlight"><pre><span></span><span class="kn">import</span> <span class="nn">pulumi</span>
<span class="kn">import</span> <span class="nn">pulumi_rabbitmq</span> <span class="k">as</span> <span class="nn">rabbitmq</span>

<span class="n">config</span> <span class="o">=</span> <span class="n">pulumi</span><span class="o">.</span><span class="n">Config</span><span class="p">()</span>
<span class="n">arguments</span> <span class="o">=</span> <span class="n">config</span><span class="o">.</span><span class="n">get</span><span class="p">(</span><span class="s2">&quot;arguments&quot;</span><span class="p">)</span>
<span class="k">if</span> <span class="n">arguments</span> <span class="ow">is</span> <span class="kc">None</span><span class="p">:</span>
    <span class="n">arguments</span> <span class="o">=</span> <span class="s2">&quot;&quot;&quot;{</span>
<span class="s2">  &quot;x-message-ttl&quot;: 5000</span>
<span class="s2">}</span>

<span class="s2">&quot;&quot;&quot;</span>
<span class="n">test_v_host</span> <span class="o">=</span> <span class="n">rabbitmq</span><span class="o">.</span><span class="n">VHost</span><span class="p">(</span><span class="s2">&quot;testVHost&quot;</span><span class="p">)</span>
<span class="n">guest</span> <span class="o">=</span> <span class="n">rabbitmq</span><span class="o">.</span><span class="n">Permissions</span><span class="p">(</span><span class="s2">&quot;guest&quot;</span><span class="p">,</span>
    <span class="n">permissions</span><span class="o">=</span><span class="p">{</span>
        <span class="s2">&quot;configure&quot;</span><span class="p">:</span> <span class="s2">&quot;.*&quot;</span><span class="p">,</span>
        <span class="s2">&quot;read&quot;</span><span class="p">:</span> <span class="s2">&quot;.*&quot;</span><span class="p">,</span>
        <span class="s2">&quot;write&quot;</span><span class="p">:</span> <span class="s2">&quot;.*&quot;</span><span class="p">,</span>
    <span class="p">},</span>
    <span class="n">user</span><span class="o">=</span><span class="s2">&quot;guest&quot;</span><span class="p">,</span>
    <span class="n">vhost</span><span class="o">=</span><span class="n">test_v_host</span><span class="o">.</span><span class="n">name</span><span class="p">)</span>
<span class="n">test_queue</span> <span class="o">=</span> <span class="n">rabbitmq</span><span class="o">.</span><span class="n">Queue</span><span class="p">(</span><span class="s2">&quot;testQueue&quot;</span><span class="p">,</span>
    <span class="n">settings</span><span class="o">=</span><span class="p">{</span>
        <span class="s2">&quot;arguments_json&quot;</span><span class="p">:</span> <span class="n">arguments</span><span class="p">,</span>
        <span class="s2">&quot;autoDelete&quot;</span><span class="p">:</span> <span class="kc">True</span><span class="p">,</span>
        <span class="s2">&quot;durable&quot;</span><span class="p">:</span> <span class="kc">False</span><span class="p">,</span>
    <span class="p">},</span>
    <span class="n">vhost</span><span class="o">=</span><span class="n">guest</span><span class="o">.</span><span class="n">vhost</span><span class="p">)</span>
</pre></div>
</div>
<dl class="field-list simple">
<dt class="field-odd">Parameters</dt>
<dd class="field-odd"><ul class="simple">
<li><p><strong>resource_name</strong> (<em>str</em>) – The name of the resource.</p></li>
<li><p><strong>opts</strong> (<a class="reference internal" href="../pulumi/#pulumi.ResourceOptions" title="pulumi.ResourceOptions"><em>pulumi.ResourceOptions</em></a>) – Options for the resource.</p></li>
<li><p><strong>name</strong> (<em>pulumi.Input</em><em>[</em><em>str</em><em>]</em>) – The name of the queue.</p></li>
<li><p><strong>settings</strong> (<em>pulumi.Input</em><em>[</em><em>dict</em><em>]</em>) – The settings of the queue. The structure is
described below.</p></li>
<li><p><strong>vhost</strong> (<em>pulumi.Input</em><em>[</em><em>str</em><em>]</em>) – The vhost to create the resource in.</p></li>
</ul>
</dd>
</dl>
<p>The <strong>settings</strong> object supports the following:</p>
<ul class="simple">
<li><p><code class="docutils literal notranslate"><span class="pre">arguments</span></code> (<code class="docutils literal notranslate"><span class="pre">pulumi.Input[dict]</span></code>) - Additional key/value settings for the queue.
All values will be sent to RabbitMQ as a string. If you require non-string
values, use <code class="docutils literal notranslate"><span class="pre">arguments_json</span></code>.</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">arguments_json</span></code> (<code class="docutils literal notranslate"><span class="pre">pulumi.Input[str]</span></code>) - A nested JSON string which contains additional
settings for the queue. This is useful for when the arguments contain
non-string values.</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">autoDelete</span></code> (<code class="docutils literal notranslate"><span class="pre">pulumi.Input[bool]</span></code>) - Whether the queue will self-delete when all
consumers have unsubscribed.</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">durable</span></code> (<code class="docutils literal notranslate"><span class="pre">pulumi.Input[bool]</span></code>) - Whether the queue survives server restarts.
Defaults to <code class="docutils literal notranslate"><span class="pre">false</span></code>.</p></li>
</ul>
<dl class="py attribute">
<dt id="pulumi_rabbitmq.Queue.name">
<code class="sig-name descname">name</code><em class="property">: pulumi.Output[str]</em><em class="property"> = None</em><a class="headerlink" href="#pulumi_rabbitmq.Queue.name" title="Permalink to this definition">¶</a></dt>
<dd><p>The name of the queue.</p>
</dd></dl>

<dl class="py attribute">
<dt id="pulumi_rabbitmq.Queue.settings">
<code class="sig-name descname">settings</code><em class="property">: pulumi.Output[dict]</em><em class="property"> = None</em><a class="headerlink" href="#pulumi_rabbitmq.Queue.settings" title="Permalink to this definition">¶</a></dt>
<dd><p>The settings of the queue. The structure is
described below.</p>
<ul class="simple">
<li><p><code class="docutils literal notranslate"><span class="pre">arguments</span></code> (<code class="docutils literal notranslate"><span class="pre">dict</span></code>) - Additional key/value settings for the queue.
All values will be sent to RabbitMQ as a string. If you require non-string
values, use <code class="docutils literal notranslate"><span class="pre">arguments_json</span></code>.</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">arguments_json</span></code> (<code class="docutils literal notranslate"><span class="pre">str</span></code>) - A nested JSON string which contains additional
settings for the queue. This is useful for when the arguments contain
non-string values.</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">autoDelete</span></code> (<code class="docutils literal notranslate"><span class="pre">bool</span></code>) - Whether the queue will self-delete when all
consumers have unsubscribed.</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">durable</span></code> (<code class="docutils literal notranslate"><span class="pre">bool</span></code>) - Whether the queue survives server restarts.
Defaults to <code class="docutils literal notranslate"><span class="pre">false</span></code>.</p></li>
</ul>
</dd></dl>

<dl class="py attribute">
<dt id="pulumi_rabbitmq.Queue.vhost">
<code class="sig-name descname">vhost</code><em class="property">: pulumi.Output[str]</em><em class="property"> = None</em><a class="headerlink" href="#pulumi_rabbitmq.Queue.vhost" title="Permalink to this definition">¶</a></dt>
<dd><p>The vhost to create the resource in.</p>
</dd></dl>

<dl class="py method">
<dt id="pulumi_rabbitmq.Queue.get">
<em class="property">static </em><code class="sig-name descname">get</code><span class="sig-paren">(</span><em class="sig-param"><span class="n">resource_name</span></em>, <em class="sig-param"><span class="n">id</span></em>, <em class="sig-param"><span class="n">opts</span><span class="o">=</span><span class="default_value">None</span></em>, <em class="sig-param"><span class="n">name</span><span class="o">=</span><span class="default_value">None</span></em>, <em class="sig-param"><span class="n">settings</span><span class="o">=</span><span class="default_value">None</span></em>, <em class="sig-param"><span class="n">vhost</span><span class="o">=</span><span class="default_value">None</span></em><span class="sig-paren">)</span><a class="headerlink" href="#pulumi_rabbitmq.Queue.get" title="Permalink to this definition">¶</a></dt>
<dd><p>Get an existing Queue resource’s state with the given name, id, and optional extra
properties used to qualify the lookup.</p>
<dl class="field-list simple">
<dt class="field-odd">Parameters</dt>
<dd class="field-odd"><ul class="simple">
<li><p><strong>resource_name</strong> (<em>str</em>) – The unique name of the resulting resource.</p></li>
<li><p><strong>id</strong> (<em>str</em>) – The unique provider ID of the resource to lookup.</p></li>
<li><p><strong>opts</strong> (<a class="reference internal" href="../pulumi/#pulumi.ResourceOptions" title="pulumi.ResourceOptions"><em>pulumi.ResourceOptions</em></a>) – Options for the resource.</p></li>
<li><p><strong>name</strong> (<em>pulumi.Input</em><em>[</em><em>str</em><em>]</em>) – The name of the queue.</p></li>
<li><p><strong>settings</strong> (<em>pulumi.Input</em><em>[</em><em>dict</em><em>]</em>) – The settings of the queue. The structure is
described below.</p></li>
<li><p><strong>vhost</strong> (<em>pulumi.Input</em><em>[</em><em>str</em><em>]</em>) – The vhost to create the resource in.</p></li>
</ul>
</dd>
</dl>
<p>The <strong>settings</strong> object supports the following:</p>
<ul class="simple">
<li><p><code class="docutils literal notranslate"><span class="pre">arguments</span></code> (<code class="docutils literal notranslate"><span class="pre">pulumi.Input[dict]</span></code>) - Additional key/value settings for the queue.
All values will be sent to RabbitMQ as a string. If you require non-string
values, use <code class="docutils literal notranslate"><span class="pre">arguments_json</span></code>.</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">arguments_json</span></code> (<code class="docutils literal notranslate"><span class="pre">pulumi.Input[str]</span></code>) - A nested JSON string which contains additional
settings for the queue. This is useful for when the arguments contain
non-string values.</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">autoDelete</span></code> (<code class="docutils literal notranslate"><span class="pre">pulumi.Input[bool]</span></code>) - Whether the queue will self-delete when all
consumers have unsubscribed.</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">durable</span></code> (<code class="docutils literal notranslate"><span class="pre">pulumi.Input[bool]</span></code>) - Whether the queue survives server restarts.
Defaults to <code class="docutils literal notranslate"><span class="pre">false</span></code>.</p></li>
</ul>
</dd></dl>

<dl class="py method">
<dt id="pulumi_rabbitmq.Queue.translate_output_property">
<code class="sig-name descname">translate_output_property</code><span class="sig-paren">(</span><em class="sig-param"><span class="n">prop</span></em><span class="sig-paren">)</span><a class="headerlink" href="#pulumi_rabbitmq.Queue.translate_output_property" title="Permalink to this definition">¶</a></dt>
<dd><p>Provides subclasses of Resource an opportunity to translate names of output properties
into a format of their choosing before writing those properties to the resource object.</p>
<dl class="field-list simple">
<dt class="field-odd">Parameters</dt>
<dd class="field-odd"><p><strong>prop</strong> (<em>str</em>) – A property name.</p>
</dd>
<dt class="field-even">Returns</dt>
<dd class="field-even"><p>A potentially transformed property name.</p>
</dd>
<dt class="field-odd">Return type</dt>
<dd class="field-odd"><p>str</p>
</dd>
</dl>
</dd></dl>

<dl class="py method">
<dt id="pulumi_rabbitmq.Queue.translate_input_property">
<code class="sig-name descname">translate_input_property</code><span class="sig-paren">(</span><em class="sig-param"><span class="n">prop</span></em><span class="sig-paren">)</span><a class="headerlink" href="#pulumi_rabbitmq.Queue.translate_input_property" title="Permalink to this definition">¶</a></dt>
<dd><p>Provides subclasses of Resource an opportunity to translate names of input properties into
a format of their choosing before sending those properties to the Pulumi engine.</p>
<dl class="field-list simple">
<dt class="field-odd">Parameters</dt>
<dd class="field-odd"><p><strong>prop</strong> (<em>str</em>) – A property name.</p>
</dd>
<dt class="field-even">Returns</dt>
<dd class="field-even"><p>A potentially transformed property name.</p>
</dd>
<dt class="field-odd">Return type</dt>
<dd class="field-odd"><p>str</p>
</dd>
</dl>
</dd></dl>

</dd></dl>

<dl class="py class">
<dt id="pulumi_rabbitmq.Shovel">
<em class="property">class </em><code class="sig-prename descclassname">pulumi_rabbitmq.</code><code class="sig-name descname">Shovel</code><span class="sig-paren">(</span><em class="sig-param"><span class="n">resource_name</span></em>, <em class="sig-param"><span class="n">opts</span><span class="o">=</span><span class="default_value">None</span></em>, <em class="sig-param"><span class="n">info</span><span class="o">=</span><span class="default_value">None</span></em>, <em class="sig-param"><span class="n">name</span><span class="o">=</span><span class="default_value">None</span></em>, <em class="sig-param"><span class="n">vhost</span><span class="o">=</span><span class="default_value">None</span></em>, <em class="sig-param"><span class="n">__props__</span><span class="o">=</span><span class="default_value">None</span></em>, <em class="sig-param"><span class="n">__name__</span><span class="o">=</span><span class="default_value">None</span></em>, <em class="sig-param"><span class="n">__opts__</span><span class="o">=</span><span class="default_value">None</span></em><span class="sig-paren">)</span><a class="headerlink" href="#pulumi_rabbitmq.Shovel" title="Permalink to this definition">¶</a></dt>
<dd><p>The <code class="docutils literal notranslate"><span class="pre">Shovel</span></code> resource creates and manages a shovel.</p>
<div class="highlight-python notranslate"><div class="highlight"><pre><span></span><span class="kn">import</span> <span class="nn">pulumi</span>
<span class="kn">import</span> <span class="nn">pulumi_rabbitmq</span> <span class="k">as</span> <span class="nn">rabbitmq</span>

<span class="n">test_v_host</span> <span class="o">=</span> <span class="n">rabbitmq</span><span class="o">.</span><span class="n">VHost</span><span class="p">(</span><span class="s2">&quot;testVHost&quot;</span><span class="p">)</span>
<span class="n">test_exchange</span> <span class="o">=</span> <span class="n">rabbitmq</span><span class="o">.</span><span class="n">Exchange</span><span class="p">(</span><span class="s2">&quot;testExchange&quot;</span><span class="p">,</span>
    <span class="n">settings</span><span class="o">=</span><span class="p">{</span>
        <span class="s2">&quot;autoDelete&quot;</span><span class="p">:</span> <span class="kc">True</span><span class="p">,</span>
        <span class="s2">&quot;durable&quot;</span><span class="p">:</span> <span class="kc">False</span><span class="p">,</span>
        <span class="s2">&quot;type&quot;</span><span class="p">:</span> <span class="s2">&quot;fanout&quot;</span><span class="p">,</span>
    <span class="p">},</span>
    <span class="n">vhost</span><span class="o">=</span><span class="n">test_v_host</span><span class="o">.</span><span class="n">name</span><span class="p">)</span>
<span class="n">test_queue</span> <span class="o">=</span> <span class="n">rabbitmq</span><span class="o">.</span><span class="n">Queue</span><span class="p">(</span><span class="s2">&quot;testQueue&quot;</span><span class="p">,</span>
    <span class="n">settings</span><span class="o">=</span><span class="p">{</span>
        <span class="s2">&quot;autoDelete&quot;</span><span class="p">:</span> <span class="kc">True</span><span class="p">,</span>
        <span class="s2">&quot;durable&quot;</span><span class="p">:</span> <span class="kc">False</span><span class="p">,</span>
    <span class="p">},</span>
    <span class="n">vhost</span><span class="o">=</span><span class="n">test_v_host</span><span class="o">.</span><span class="n">name</span><span class="p">)</span>
<span class="n">shovel_test</span> <span class="o">=</span> <span class="n">rabbitmq</span><span class="o">.</span><span class="n">Shovel</span><span class="p">(</span><span class="s2">&quot;shovelTest&quot;</span><span class="p">,</span>
    <span class="n">info</span><span class="o">=</span><span class="p">{</span>
        <span class="s2">&quot;destinationQueue&quot;</span><span class="p">:</span> <span class="n">test_queue</span><span class="o">.</span><span class="n">name</span><span class="p">,</span>
        <span class="s2">&quot;destinationUri&quot;</span><span class="p">:</span> <span class="s2">&quot;amqp:///test&quot;</span><span class="p">,</span>
        <span class="s2">&quot;sourceExchange&quot;</span><span class="p">:</span> <span class="n">test_exchange</span><span class="o">.</span><span class="n">name</span><span class="p">,</span>
        <span class="s2">&quot;sourceExchangeKey&quot;</span><span class="p">:</span> <span class="s2">&quot;test&quot;</span><span class="p">,</span>
        <span class="s2">&quot;sourceUri&quot;</span><span class="p">:</span> <span class="s2">&quot;amqp:///test&quot;</span><span class="p">,</span>
    <span class="p">},</span>
    <span class="n">vhost</span><span class="o">=</span><span class="n">test_v_host</span><span class="o">.</span><span class="n">name</span><span class="p">)</span>
</pre></div>
</div>
<dl class="field-list simple">
<dt class="field-odd">Parameters</dt>
<dd class="field-odd"><ul class="simple">
<li><p><strong>resource_name</strong> (<em>str</em>) – The name of the resource.</p></li>
<li><p><strong>opts</strong> (<a class="reference internal" href="../pulumi/#pulumi.ResourceOptions" title="pulumi.ResourceOptions"><em>pulumi.ResourceOptions</em></a>) – Options for the resource.</p></li>
<li><p><strong>info</strong> (<em>pulumi.Input</em><em>[</em><em>dict</em><em>]</em>) – The settings of the shovel. The structure is
described below.</p></li>
<li><p><strong>name</strong> (<em>pulumi.Input</em><em>[</em><em>str</em><em>]</em>) – The shovel name.</p></li>
<li><p><strong>vhost</strong> (<em>pulumi.Input</em><em>[</em><em>str</em><em>]</em>) – The vhost to create the resource in.</p></li>
</ul>
</dd>
</dl>
<p>The <strong>info</strong> object supports the following:</p>
<ul class="simple">
<li><p><code class="docutils literal notranslate"><span class="pre">ackMode</span></code> (<code class="docutils literal notranslate"><span class="pre">pulumi.Input[str]</span></code>) - Determines how the shovel should acknowledge messages.
Defaults to <code class="docutils literal notranslate"><span class="pre">on-confirm</span></code>.</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">addForwardHeaders</span></code> (<code class="docutils literal notranslate"><span class="pre">pulumi.Input[bool]</span></code>) - Whether to amqp shovel headers.
Defaults to <code class="docutils literal notranslate"><span class="pre">false</span></code>.</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">deleteAfter</span></code> (<code class="docutils literal notranslate"><span class="pre">pulumi.Input[str]</span></code>) - Determines when (if ever) the shovel should delete itself .
Defaults to <code class="docutils literal notranslate"><span class="pre">never</span></code>.</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">destinationExchange</span></code> (<code class="docutils literal notranslate"><span class="pre">pulumi.Input[str]</span></code>) - The exchange to which messages should be published.
Either this or destination_queue must be specified but not both.</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">destinationExchangeKey</span></code> (<code class="docutils literal notranslate"><span class="pre">pulumi.Input[str]</span></code>) - The routing key when using destination_exchange.</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">destinationQueue</span></code> (<code class="docutils literal notranslate"><span class="pre">pulumi.Input[str]</span></code>) - The queue to which messages should be published.
Either this or destination_exchange must be specified but not both.</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">destinationUri</span></code> (<code class="docutils literal notranslate"><span class="pre">pulumi.Input[str]</span></code>) - The amqp uri for the destination .</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">prefetchCount</span></code> (<code class="docutils literal notranslate"><span class="pre">pulumi.Input[float]</span></code>) - The maximum number of unacknowledged messages copied over a shovel at any one time.
Defaults to <code class="docutils literal notranslate"><span class="pre">1000</span></code>.</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">reconnectDelay</span></code> (<code class="docutils literal notranslate"><span class="pre">pulumi.Input[float]</span></code>) - The duration in seconds to reconnect to a broker after disconnected.
Defaults to <code class="docutils literal notranslate"><span class="pre">1</span></code>.</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">sourceExchange</span></code> (<code class="docutils literal notranslate"><span class="pre">pulumi.Input[str]</span></code>) - The exchange from which to consume.
Either this or source_queue must be specified but not both.</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">sourceExchangeKey</span></code> (<code class="docutils literal notranslate"><span class="pre">pulumi.Input[str]</span></code>) - The routing key when using source_exchange.</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">sourceQueue</span></code> (<code class="docutils literal notranslate"><span class="pre">pulumi.Input[str]</span></code>) - The queue from which to consume.
Either this or source_exchange must be specified but not both.</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">sourceUri</span></code> (<code class="docutils literal notranslate"><span class="pre">pulumi.Input[str]</span></code>) - The amqp uri for the source.</p></li>
</ul>
<dl class="py attribute">
<dt id="pulumi_rabbitmq.Shovel.info">
<code class="sig-name descname">info</code><em class="property">: pulumi.Output[dict]</em><em class="property"> = None</em><a class="headerlink" href="#pulumi_rabbitmq.Shovel.info" title="Permalink to this definition">¶</a></dt>
<dd><p>The settings of the shovel. The structure is
described below.</p>
<ul class="simple">
<li><p><code class="docutils literal notranslate"><span class="pre">ackMode</span></code> (<code class="docutils literal notranslate"><span class="pre">str</span></code>) - Determines how the shovel should acknowledge messages.
Defaults to <code class="docutils literal notranslate"><span class="pre">on-confirm</span></code>.</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">addForwardHeaders</span></code> (<code class="docutils literal notranslate"><span class="pre">bool</span></code>) - Whether to amqp shovel headers.
Defaults to <code class="docutils literal notranslate"><span class="pre">false</span></code>.</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">deleteAfter</span></code> (<code class="docutils literal notranslate"><span class="pre">str</span></code>) - Determines when (if ever) the shovel should delete itself .
Defaults to <code class="docutils literal notranslate"><span class="pre">never</span></code>.</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">destinationExchange</span></code> (<code class="docutils literal notranslate"><span class="pre">str</span></code>) - The exchange to which messages should be published.
Either this or destination_queue must be specified but not both.</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">destinationExchangeKey</span></code> (<code class="docutils literal notranslate"><span class="pre">str</span></code>) - The routing key when using destination_exchange.</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">destinationQueue</span></code> (<code class="docutils literal notranslate"><span class="pre">str</span></code>) - The queue to which messages should be published.
Either this or destination_exchange must be specified but not both.</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">destinationUri</span></code> (<code class="docutils literal notranslate"><span class="pre">str</span></code>) - The amqp uri for the destination .</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">prefetchCount</span></code> (<code class="docutils literal notranslate"><span class="pre">float</span></code>) - The maximum number of unacknowledged messages copied over a shovel at any one time.
Defaults to <code class="docutils literal notranslate"><span class="pre">1000</span></code>.</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">reconnectDelay</span></code> (<code class="docutils literal notranslate"><span class="pre">float</span></code>) - The duration in seconds to reconnect to a broker after disconnected.
Defaults to <code class="docutils literal notranslate"><span class="pre">1</span></code>.</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">sourceExchange</span></code> (<code class="docutils literal notranslate"><span class="pre">str</span></code>) - The exchange from which to consume.
Either this or source_queue must be specified but not both.</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">sourceExchangeKey</span></code> (<code class="docutils literal notranslate"><span class="pre">str</span></code>) - The routing key when using source_exchange.</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">sourceQueue</span></code> (<code class="docutils literal notranslate"><span class="pre">str</span></code>) - The queue from which to consume.
Either this or source_exchange must be specified but not both.</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">sourceUri</span></code> (<code class="docutils literal notranslate"><span class="pre">str</span></code>) - The amqp uri for the source.</p></li>
</ul>
</dd></dl>

<dl class="py attribute">
<dt id="pulumi_rabbitmq.Shovel.name">
<code class="sig-name descname">name</code><em class="property">: pulumi.Output[str]</em><em class="property"> = None</em><a class="headerlink" href="#pulumi_rabbitmq.Shovel.name" title="Permalink to this definition">¶</a></dt>
<dd><p>The shovel name.</p>
</dd></dl>

<dl class="py attribute">
<dt id="pulumi_rabbitmq.Shovel.vhost">
<code class="sig-name descname">vhost</code><em class="property">: pulumi.Output[str]</em><em class="property"> = None</em><a class="headerlink" href="#pulumi_rabbitmq.Shovel.vhost" title="Permalink to this definition">¶</a></dt>
<dd><p>The vhost to create the resource in.</p>
</dd></dl>

<dl class="py method">
<dt id="pulumi_rabbitmq.Shovel.get">
<em class="property">static </em><code class="sig-name descname">get</code><span class="sig-paren">(</span><em class="sig-param"><span class="n">resource_name</span></em>, <em class="sig-param"><span class="n">id</span></em>, <em class="sig-param"><span class="n">opts</span><span class="o">=</span><span class="default_value">None</span></em>, <em class="sig-param"><span class="n">info</span><span class="o">=</span><span class="default_value">None</span></em>, <em class="sig-param"><span class="n">name</span><span class="o">=</span><span class="default_value">None</span></em>, <em class="sig-param"><span class="n">vhost</span><span class="o">=</span><span class="default_value">None</span></em><span class="sig-paren">)</span><a class="headerlink" href="#pulumi_rabbitmq.Shovel.get" title="Permalink to this definition">¶</a></dt>
<dd><p>Get an existing Shovel resource’s state with the given name, id, and optional extra
properties used to qualify the lookup.</p>
<dl class="field-list simple">
<dt class="field-odd">Parameters</dt>
<dd class="field-odd"><ul class="simple">
<li><p><strong>resource_name</strong> (<em>str</em>) – The unique name of the resulting resource.</p></li>
<li><p><strong>id</strong> (<em>str</em>) – The unique provider ID of the resource to lookup.</p></li>
<li><p><strong>opts</strong> (<a class="reference internal" href="../pulumi/#pulumi.ResourceOptions" title="pulumi.ResourceOptions"><em>pulumi.ResourceOptions</em></a>) – Options for the resource.</p></li>
<li><p><strong>info</strong> (<em>pulumi.Input</em><em>[</em><em>dict</em><em>]</em>) – The settings of the shovel. The structure is
described below.</p></li>
<li><p><strong>name</strong> (<em>pulumi.Input</em><em>[</em><em>str</em><em>]</em>) – The shovel name.</p></li>
<li><p><strong>vhost</strong> (<em>pulumi.Input</em><em>[</em><em>str</em><em>]</em>) – The vhost to create the resource in.</p></li>
</ul>
</dd>
</dl>
<p>The <strong>info</strong> object supports the following:</p>
<ul class="simple">
<li><p><code class="docutils literal notranslate"><span class="pre">ackMode</span></code> (<code class="docutils literal notranslate"><span class="pre">pulumi.Input[str]</span></code>) - Determines how the shovel should acknowledge messages.
Defaults to <code class="docutils literal notranslate"><span class="pre">on-confirm</span></code>.</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">addForwardHeaders</span></code> (<code class="docutils literal notranslate"><span class="pre">pulumi.Input[bool]</span></code>) - Whether to amqp shovel headers.
Defaults to <code class="docutils literal notranslate"><span class="pre">false</span></code>.</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">deleteAfter</span></code> (<code class="docutils literal notranslate"><span class="pre">pulumi.Input[str]</span></code>) - Determines when (if ever) the shovel should delete itself .
Defaults to <code class="docutils literal notranslate"><span class="pre">never</span></code>.</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">destinationExchange</span></code> (<code class="docutils literal notranslate"><span class="pre">pulumi.Input[str]</span></code>) - The exchange to which messages should be published.
Either this or destination_queue must be specified but not both.</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">destinationExchangeKey</span></code> (<code class="docutils literal notranslate"><span class="pre">pulumi.Input[str]</span></code>) - The routing key when using destination_exchange.</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">destinationQueue</span></code> (<code class="docutils literal notranslate"><span class="pre">pulumi.Input[str]</span></code>) - The queue to which messages should be published.
Either this or destination_exchange must be specified but not both.</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">destinationUri</span></code> (<code class="docutils literal notranslate"><span class="pre">pulumi.Input[str]</span></code>) - The amqp uri for the destination .</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">prefetchCount</span></code> (<code class="docutils literal notranslate"><span class="pre">pulumi.Input[float]</span></code>) - The maximum number of unacknowledged messages copied over a shovel at any one time.
Defaults to <code class="docutils literal notranslate"><span class="pre">1000</span></code>.</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">reconnectDelay</span></code> (<code class="docutils literal notranslate"><span class="pre">pulumi.Input[float]</span></code>) - The duration in seconds to reconnect to a broker after disconnected.
Defaults to <code class="docutils literal notranslate"><span class="pre">1</span></code>.</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">sourceExchange</span></code> (<code class="docutils literal notranslate"><span class="pre">pulumi.Input[str]</span></code>) - The exchange from which to consume.
Either this or source_queue must be specified but not both.</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">sourceExchangeKey</span></code> (<code class="docutils literal notranslate"><span class="pre">pulumi.Input[str]</span></code>) - The routing key when using source_exchange.</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">sourceQueue</span></code> (<code class="docutils literal notranslate"><span class="pre">pulumi.Input[str]</span></code>) - The queue from which to consume.
Either this or source_exchange must be specified but not both.</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">sourceUri</span></code> (<code class="docutils literal notranslate"><span class="pre">pulumi.Input[str]</span></code>) - The amqp uri for the source.</p></li>
</ul>
</dd></dl>

<dl class="py method">
<dt id="pulumi_rabbitmq.Shovel.translate_output_property">
<code class="sig-name descname">translate_output_property</code><span class="sig-paren">(</span><em class="sig-param"><span class="n">prop</span></em><span class="sig-paren">)</span><a class="headerlink" href="#pulumi_rabbitmq.Shovel.translate_output_property" title="Permalink to this definition">¶</a></dt>
<dd><p>Provides subclasses of Resource an opportunity to translate names of output properties
into a format of their choosing before writing those properties to the resource object.</p>
<dl class="field-list simple">
<dt class="field-odd">Parameters</dt>
<dd class="field-odd"><p><strong>prop</strong> (<em>str</em>) – A property name.</p>
</dd>
<dt class="field-even">Returns</dt>
<dd class="field-even"><p>A potentially transformed property name.</p>
</dd>
<dt class="field-odd">Return type</dt>
<dd class="field-odd"><p>str</p>
</dd>
</dl>
</dd></dl>

<dl class="py method">
<dt id="pulumi_rabbitmq.Shovel.translate_input_property">
<code class="sig-name descname">translate_input_property</code><span class="sig-paren">(</span><em class="sig-param"><span class="n">prop</span></em><span class="sig-paren">)</span><a class="headerlink" href="#pulumi_rabbitmq.Shovel.translate_input_property" title="Permalink to this definition">¶</a></dt>
<dd><p>Provides subclasses of Resource an opportunity to translate names of input properties into
a format of their choosing before sending those properties to the Pulumi engine.</p>
<dl class="field-list simple">
<dt class="field-odd">Parameters</dt>
<dd class="field-odd"><p><strong>prop</strong> (<em>str</em>) – A property name.</p>
</dd>
<dt class="field-even">Returns</dt>
<dd class="field-even"><p>A potentially transformed property name.</p>
</dd>
<dt class="field-odd">Return type</dt>
<dd class="field-odd"><p>str</p>
</dd>
</dl>
</dd></dl>

</dd></dl>

<dl class="py class">
<dt id="pulumi_rabbitmq.TopicPermissions">
<em class="property">class </em><code class="sig-prename descclassname">pulumi_rabbitmq.</code><code class="sig-name descname">TopicPermissions</code><span class="sig-paren">(</span><em class="sig-param"><span class="n">resource_name</span></em>, <em class="sig-param"><span class="n">opts</span><span class="o">=</span><span class="default_value">None</span></em>, <em class="sig-param"><span class="n">permissions</span><span class="o">=</span><span class="default_value">None</span></em>, <em class="sig-param"><span class="n">user</span><span class="o">=</span><span class="default_value">None</span></em>, <em class="sig-param"><span class="n">vhost</span><span class="o">=</span><span class="default_value">None</span></em>, <em class="sig-param"><span class="n">__props__</span><span class="o">=</span><span class="default_value">None</span></em>, <em class="sig-param"><span class="n">__name__</span><span class="o">=</span><span class="default_value">None</span></em>, <em class="sig-param"><span class="n">__opts__</span><span class="o">=</span><span class="default_value">None</span></em><span class="sig-paren">)</span><a class="headerlink" href="#pulumi_rabbitmq.TopicPermissions" title="Permalink to this definition">¶</a></dt>
<dd><p>The <code class="docutils literal notranslate"><span class="pre">TopicPermissions</span></code> resource creates and manages a user’s set of
topic permissions.</p>
<div class="highlight-python notranslate"><div class="highlight"><pre><span></span><span class="kn">import</span> <span class="nn">pulumi</span>
<span class="kn">import</span> <span class="nn">pulumi_rabbitmq</span> <span class="k">as</span> <span class="nn">rabbitmq</span>

<span class="n">test_v_host</span> <span class="o">=</span> <span class="n">rabbitmq</span><span class="o">.</span><span class="n">VHost</span><span class="p">(</span><span class="s2">&quot;testVHost&quot;</span><span class="p">)</span>
<span class="n">test_user</span> <span class="o">=</span> <span class="n">rabbitmq</span><span class="o">.</span><span class="n">User</span><span class="p">(</span><span class="s2">&quot;testUser&quot;</span><span class="p">,</span>
    <span class="n">password</span><span class="o">=</span><span class="s2">&quot;foobar&quot;</span><span class="p">,</span>
    <span class="n">tags</span><span class="o">=</span><span class="p">[</span><span class="s2">&quot;administrator&quot;</span><span class="p">])</span>
<span class="n">test_topic_permissions</span> <span class="o">=</span> <span class="n">rabbitmq</span><span class="o">.</span><span class="n">TopicPermissions</span><span class="p">(</span><span class="s2">&quot;testTopicPermissions&quot;</span><span class="p">,</span>
    <span class="n">permissions</span><span class="o">=</span><span class="p">[{</span>
        <span class="s2">&quot;exchange&quot;</span><span class="p">:</span> <span class="s2">&quot;amq.topic&quot;</span><span class="p">,</span>
        <span class="s2">&quot;read&quot;</span><span class="p">:</span> <span class="s2">&quot;.*&quot;</span><span class="p">,</span>
        <span class="s2">&quot;write&quot;</span><span class="p">:</span> <span class="s2">&quot;.*&quot;</span><span class="p">,</span>
    <span class="p">}],</span>
    <span class="n">user</span><span class="o">=</span><span class="n">test_user</span><span class="o">.</span><span class="n">name</span><span class="p">,</span>
    <span class="n">vhost</span><span class="o">=</span><span class="n">test_v_host</span><span class="o">.</span><span class="n">name</span><span class="p">)</span>
</pre></div>
</div>
<dl class="field-list simple">
<dt class="field-odd">Parameters</dt>
<dd class="field-odd"><ul class="simple">
<li><p><strong>resource_name</strong> (<em>str</em>) – The name of the resource.</p></li>
<li><p><strong>opts</strong> (<a class="reference internal" href="../pulumi/#pulumi.ResourceOptions" title="pulumi.ResourceOptions"><em>pulumi.ResourceOptions</em></a>) – Options for the resource.</p></li>
<li><p><strong>permissions</strong> (<em>pulumi.Input</em><em>[</em><em>list</em><em>]</em>) – The settings of the permissions. The structure is
described below.</p></li>
<li><p><strong>user</strong> (<em>pulumi.Input</em><em>[</em><em>str</em><em>]</em>) – The user to apply the permissions to.</p></li>
<li><p><strong>vhost</strong> (<em>pulumi.Input</em><em>[</em><em>str</em><em>]</em>) – The vhost to create the resource in.</p></li>
</ul>
</dd>
</dl>
<p>The <strong>permissions</strong> object supports the following:</p>
<ul class="simple">
<li><p><code class="docutils literal notranslate"><span class="pre">exchange</span></code> (<code class="docutils literal notranslate"><span class="pre">pulumi.Input[str]</span></code>) - The exchange to set the permissions for.</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">read</span></code> (<code class="docutils literal notranslate"><span class="pre">pulumi.Input[str]</span></code>) - The “read” ACL.</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">write</span></code> (<code class="docutils literal notranslate"><span class="pre">pulumi.Input[str]</span></code>) - The “write” ACL.</p></li>
</ul>
<dl class="py attribute">
<dt id="pulumi_rabbitmq.TopicPermissions.permissions">
<code class="sig-name descname">permissions</code><em class="property">: pulumi.Output[list]</em><em class="property"> = None</em><a class="headerlink" href="#pulumi_rabbitmq.TopicPermissions.permissions" title="Permalink to this definition">¶</a></dt>
<dd><p>The settings of the permissions. The structure is
described below.</p>
<ul class="simple">
<li><p><code class="docutils literal notranslate"><span class="pre">exchange</span></code> (<code class="docutils literal notranslate"><span class="pre">str</span></code>) - The exchange to set the permissions for.</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">read</span></code> (<code class="docutils literal notranslate"><span class="pre">str</span></code>) - The “read” ACL.</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">write</span></code> (<code class="docutils literal notranslate"><span class="pre">str</span></code>) - The “write” ACL.</p></li>
</ul>
</dd></dl>

<dl class="py attribute">
<dt id="pulumi_rabbitmq.TopicPermissions.user">
<code class="sig-name descname">user</code><em class="property">: pulumi.Output[str]</em><em class="property"> = None</em><a class="headerlink" href="#pulumi_rabbitmq.TopicPermissions.user" title="Permalink to this definition">¶</a></dt>
<dd><p>The user to apply the permissions to.</p>
</dd></dl>

<dl class="py attribute">
<dt id="pulumi_rabbitmq.TopicPermissions.vhost">
<code class="sig-name descname">vhost</code><em class="property">: pulumi.Output[str]</em><em class="property"> = None</em><a class="headerlink" href="#pulumi_rabbitmq.TopicPermissions.vhost" title="Permalink to this definition">¶</a></dt>
<dd><p>The vhost to create the resource in.</p>
</dd></dl>

<dl class="py method">
<dt id="pulumi_rabbitmq.TopicPermissions.get">
<em class="property">static </em><code class="sig-name descname">get</code><span class="sig-paren">(</span><em class="sig-param"><span class="n">resource_name</span></em>, <em class="sig-param"><span class="n">id</span></em>, <em class="sig-param"><span class="n">opts</span><span class="o">=</span><span class="default_value">None</span></em>, <em class="sig-param"><span class="n">permissions</span><span class="o">=</span><span class="default_value">None</span></em>, <em class="sig-param"><span class="n">user</span><span class="o">=</span><span class="default_value">None</span></em>, <em class="sig-param"><span class="n">vhost</span><span class="o">=</span><span class="default_value">None</span></em><span class="sig-paren">)</span><a class="headerlink" href="#pulumi_rabbitmq.TopicPermissions.get" title="Permalink to this definition">¶</a></dt>
<dd><p>Get an existing TopicPermissions resource’s state with the given name, id, and optional extra
properties used to qualify the lookup.</p>
<dl class="field-list simple">
<dt class="field-odd">Parameters</dt>
<dd class="field-odd"><ul class="simple">
<li><p><strong>resource_name</strong> (<em>str</em>) – The unique name of the resulting resource.</p></li>
<li><p><strong>id</strong> (<em>str</em>) – The unique provider ID of the resource to lookup.</p></li>
<li><p><strong>opts</strong> (<a class="reference internal" href="../pulumi/#pulumi.ResourceOptions" title="pulumi.ResourceOptions"><em>pulumi.ResourceOptions</em></a>) – Options for the resource.</p></li>
<li><p><strong>permissions</strong> (<em>pulumi.Input</em><em>[</em><em>list</em><em>]</em>) – The settings of the permissions. The structure is
described below.</p></li>
<li><p><strong>user</strong> (<em>pulumi.Input</em><em>[</em><em>str</em><em>]</em>) – The user to apply the permissions to.</p></li>
<li><p><strong>vhost</strong> (<em>pulumi.Input</em><em>[</em><em>str</em><em>]</em>) – The vhost to create the resource in.</p></li>
</ul>
</dd>
</dl>
<p>The <strong>permissions</strong> object supports the following:</p>
<ul class="simple">
<li><p><code class="docutils literal notranslate"><span class="pre">exchange</span></code> (<code class="docutils literal notranslate"><span class="pre">pulumi.Input[str]</span></code>) - The exchange to set the permissions for.</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">read</span></code> (<code class="docutils literal notranslate"><span class="pre">pulumi.Input[str]</span></code>) - The “read” ACL.</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">write</span></code> (<code class="docutils literal notranslate"><span class="pre">pulumi.Input[str]</span></code>) - The “write” ACL.</p></li>
</ul>
</dd></dl>

<dl class="py method">
<dt id="pulumi_rabbitmq.TopicPermissions.translate_output_property">
<code class="sig-name descname">translate_output_property</code><span class="sig-paren">(</span><em class="sig-param"><span class="n">prop</span></em><span class="sig-paren">)</span><a class="headerlink" href="#pulumi_rabbitmq.TopicPermissions.translate_output_property" title="Permalink to this definition">¶</a></dt>
<dd><p>Provides subclasses of Resource an opportunity to translate names of output properties
into a format of their choosing before writing those properties to the resource object.</p>
<dl class="field-list simple">
<dt class="field-odd">Parameters</dt>
<dd class="field-odd"><p><strong>prop</strong> (<em>str</em>) – A property name.</p>
</dd>
<dt class="field-even">Returns</dt>
<dd class="field-even"><p>A potentially transformed property name.</p>
</dd>
<dt class="field-odd">Return type</dt>
<dd class="field-odd"><p>str</p>
</dd>
</dl>
</dd></dl>

<dl class="py method">
<dt id="pulumi_rabbitmq.TopicPermissions.translate_input_property">
<code class="sig-name descname">translate_input_property</code><span class="sig-paren">(</span><em class="sig-param"><span class="n">prop</span></em><span class="sig-paren">)</span><a class="headerlink" href="#pulumi_rabbitmq.TopicPermissions.translate_input_property" title="Permalink to this definition">¶</a></dt>
<dd><p>Provides subclasses of Resource an opportunity to translate names of input properties into
a format of their choosing before sending those properties to the Pulumi engine.</p>
<dl class="field-list simple">
<dt class="field-odd">Parameters</dt>
<dd class="field-odd"><p><strong>prop</strong> (<em>str</em>) – A property name.</p>
</dd>
<dt class="field-even">Returns</dt>
<dd class="field-even"><p>A potentially transformed property name.</p>
</dd>
<dt class="field-odd">Return type</dt>
<dd class="field-odd"><p>str</p>
</dd>
</dl>
</dd></dl>

</dd></dl>

<dl class="py class">
<dt id="pulumi_rabbitmq.User">
<em class="property">class </em><code class="sig-prename descclassname">pulumi_rabbitmq.</code><code class="sig-name descname">User</code><span class="sig-paren">(</span><em class="sig-param"><span class="n">resource_name</span></em>, <em class="sig-param"><span class="n">opts</span><span class="o">=</span><span class="default_value">None</span></em>, <em class="sig-param"><span class="n">name</span><span class="o">=</span><span class="default_value">None</span></em>, <em class="sig-param"><span class="n">password</span><span class="o">=</span><span class="default_value">None</span></em>, <em class="sig-param"><span class="n">tags</span><span class="o">=</span><span class="default_value">None</span></em>, <em class="sig-param"><span class="n">__props__</span><span class="o">=</span><span class="default_value">None</span></em>, <em class="sig-param"><span class="n">__name__</span><span class="o">=</span><span class="default_value">None</span></em>, <em class="sig-param"><span class="n">__opts__</span><span class="o">=</span><span class="default_value">None</span></em><span class="sig-paren">)</span><a class="headerlink" href="#pulumi_rabbitmq.User" title="Permalink to this definition">¶</a></dt>
<dd><p>The <code class="docutils literal notranslate"><span class="pre">User</span></code> resource creates and manages a user.</p>
<blockquote>
<div><p><strong>Note:</strong> All arguments including username and password will be stored in the raw state as plain-text.
<a class="reference external" href="https://www.terraform.io/docs/state/sensitive-data.html">Read more about sensitive data in state</a>.</p>
</div></blockquote>
<div class="highlight-python notranslate"><div class="highlight"><pre><span></span><span class="kn">import</span> <span class="nn">pulumi</span>
<span class="kn">import</span> <span class="nn">pulumi_rabbitmq</span> <span class="k">as</span> <span class="nn">rabbitmq</span>

<span class="n">test</span> <span class="o">=</span> <span class="n">rabbitmq</span><span class="o">.</span><span class="n">User</span><span class="p">(</span><span class="s2">&quot;test&quot;</span><span class="p">,</span>
    <span class="n">password</span><span class="o">=</span><span class="s2">&quot;foobar&quot;</span><span class="p">,</span>
    <span class="n">tags</span><span class="o">=</span><span class="p">[</span>
        <span class="s2">&quot;administrator&quot;</span><span class="p">,</span>
        <span class="s2">&quot;management&quot;</span><span class="p">,</span>
    <span class="p">])</span>
</pre></div>
</div>
<dl class="field-list simple">
<dt class="field-odd">Parameters</dt>
<dd class="field-odd"><ul class="simple">
<li><p><strong>resource_name</strong> (<em>str</em>) – The name of the resource.</p></li>
<li><p><strong>opts</strong> (<a class="reference internal" href="../pulumi/#pulumi.ResourceOptions" title="pulumi.ResourceOptions"><em>pulumi.ResourceOptions</em></a>) – Options for the resource.</p></li>
<li><p><strong>name</strong> (<em>pulumi.Input</em><em>[</em><em>str</em><em>]</em>) – The name of the user.</p></li>
<li><p><strong>password</strong> (<em>pulumi.Input</em><em>[</em><em>str</em><em>]</em>) – The password of the user. The value of this argument
is plain-text so make sure to secure where this is defined.</p></li>
<li><p><strong>tags</strong> (<em>pulumi.Input</em><em>[</em><em>list</em><em>]</em>) – Which permission model to apply to the user. Valid
options are: management, policymaker, monitoring, and administrator.</p></li>
</ul>
</dd>
</dl>
<dl class="py attribute">
<dt id="pulumi_rabbitmq.User.name">
<code class="sig-name descname">name</code><em class="property">: pulumi.Output[str]</em><em class="property"> = None</em><a class="headerlink" href="#pulumi_rabbitmq.User.name" title="Permalink to this definition">¶</a></dt>
<dd><p>The name of the user.</p>
</dd></dl>

<dl class="py attribute">
<dt id="pulumi_rabbitmq.User.password">
<code class="sig-name descname">password</code><em class="property">: pulumi.Output[str]</em><em class="property"> = None</em><a class="headerlink" href="#pulumi_rabbitmq.User.password" title="Permalink to this definition">¶</a></dt>
<dd><p>The password of the user. The value of this argument
is plain-text so make sure to secure where this is defined.</p>
</dd></dl>

<dl class="py attribute">
<dt id="pulumi_rabbitmq.User.tags">
<code class="sig-name descname">tags</code><em class="property">: pulumi.Output[list]</em><em class="property"> = None</em><a class="headerlink" href="#pulumi_rabbitmq.User.tags" title="Permalink to this definition">¶</a></dt>
<dd><p>Which permission model to apply to the user. Valid
options are: management, policymaker, monitoring, and administrator.</p>
</dd></dl>

<dl class="py method">
<dt id="pulumi_rabbitmq.User.get">
<em class="property">static </em><code class="sig-name descname">get</code><span class="sig-paren">(</span><em class="sig-param"><span class="n">resource_name</span></em>, <em class="sig-param"><span class="n">id</span></em>, <em class="sig-param"><span class="n">opts</span><span class="o">=</span><span class="default_value">None</span></em>, <em class="sig-param"><span class="n">name</span><span class="o">=</span><span class="default_value">None</span></em>, <em class="sig-param"><span class="n">password</span><span class="o">=</span><span class="default_value">None</span></em>, <em class="sig-param"><span class="n">tags</span><span class="o">=</span><span class="default_value">None</span></em><span class="sig-paren">)</span><a class="headerlink" href="#pulumi_rabbitmq.User.get" title="Permalink to this definition">¶</a></dt>
<dd><p>Get an existing User resource’s state with the given name, id, and optional extra
properties used to qualify the lookup.</p>
<dl class="field-list simple">
<dt class="field-odd">Parameters</dt>
<dd class="field-odd"><ul class="simple">
<li><p><strong>resource_name</strong> (<em>str</em>) – The unique name of the resulting resource.</p></li>
<li><p><strong>id</strong> (<em>str</em>) – The unique provider ID of the resource to lookup.</p></li>
<li><p><strong>opts</strong> (<a class="reference internal" href="../pulumi/#pulumi.ResourceOptions" title="pulumi.ResourceOptions"><em>pulumi.ResourceOptions</em></a>) – Options for the resource.</p></li>
<li><p><strong>name</strong> (<em>pulumi.Input</em><em>[</em><em>str</em><em>]</em>) – The name of the user.</p></li>
<li><p><strong>password</strong> (<em>pulumi.Input</em><em>[</em><em>str</em><em>]</em>) – The password of the user. The value of this argument
is plain-text so make sure to secure where this is defined.</p></li>
<li><p><strong>tags</strong> (<em>pulumi.Input</em><em>[</em><em>list</em><em>]</em>) – Which permission model to apply to the user. Valid
options are: management, policymaker, monitoring, and administrator.</p></li>
</ul>
</dd>
</dl>
</dd></dl>

<dl class="py method">
<dt id="pulumi_rabbitmq.User.translate_output_property">
<code class="sig-name descname">translate_output_property</code><span class="sig-paren">(</span><em class="sig-param"><span class="n">prop</span></em><span class="sig-paren">)</span><a class="headerlink" href="#pulumi_rabbitmq.User.translate_output_property" title="Permalink to this definition">¶</a></dt>
<dd><p>Provides subclasses of Resource an opportunity to translate names of output properties
into a format of their choosing before writing those properties to the resource object.</p>
<dl class="field-list simple">
<dt class="field-odd">Parameters</dt>
<dd class="field-odd"><p><strong>prop</strong> (<em>str</em>) – A property name.</p>
</dd>
<dt class="field-even">Returns</dt>
<dd class="field-even"><p>A potentially transformed property name.</p>
</dd>
<dt class="field-odd">Return type</dt>
<dd class="field-odd"><p>str</p>
</dd>
</dl>
</dd></dl>

<dl class="py method">
<dt id="pulumi_rabbitmq.User.translate_input_property">
<code class="sig-name descname">translate_input_property</code><span class="sig-paren">(</span><em class="sig-param"><span class="n">prop</span></em><span class="sig-paren">)</span><a class="headerlink" href="#pulumi_rabbitmq.User.translate_input_property" title="Permalink to this definition">¶</a></dt>
<dd><p>Provides subclasses of Resource an opportunity to translate names of input properties into
a format of their choosing before sending those properties to the Pulumi engine.</p>
<dl class="field-list simple">
<dt class="field-odd">Parameters</dt>
<dd class="field-odd"><p><strong>prop</strong> (<em>str</em>) – A property name.</p>
</dd>
<dt class="field-even">Returns</dt>
<dd class="field-even"><p>A potentially transformed property name.</p>
</dd>
<dt class="field-odd">Return type</dt>
<dd class="field-odd"><p>str</p>
</dd>
</dl>
</dd></dl>

</dd></dl>

<dl class="py class">
<dt id="pulumi_rabbitmq.VHost">
<em class="property">class </em><code class="sig-prename descclassname">pulumi_rabbitmq.</code><code class="sig-name descname">VHost</code><span class="sig-paren">(</span><em class="sig-param"><span class="n">resource_name</span></em>, <em class="sig-param"><span class="n">opts</span><span class="o">=</span><span class="default_value">None</span></em>, <em class="sig-param"><span class="n">name</span><span class="o">=</span><span class="default_value">None</span></em>, <em class="sig-param"><span class="n">__props__</span><span class="o">=</span><span class="default_value">None</span></em>, <em class="sig-param"><span class="n">__name__</span><span class="o">=</span><span class="default_value">None</span></em>, <em class="sig-param"><span class="n">__opts__</span><span class="o">=</span><span class="default_value">None</span></em><span class="sig-paren">)</span><a class="headerlink" href="#pulumi_rabbitmq.VHost" title="Permalink to this definition">¶</a></dt>
<dd><p>The <code class="docutils literal notranslate"><span class="pre">VHost</span></code> resource creates and manages a vhost.</p>
<div class="highlight-python notranslate"><div class="highlight"><pre><span></span><span class="kn">import</span> <span class="nn">pulumi</span>
<span class="kn">import</span> <span class="nn">pulumi_rabbitmq</span> <span class="k">as</span> <span class="nn">rabbitmq</span>

<span class="n">my_vhost</span> <span class="o">=</span> <span class="n">rabbitmq</span><span class="o">.</span><span class="n">VHost</span><span class="p">(</span><span class="s2">&quot;myVhost&quot;</span><span class="p">)</span>
</pre></div>
</div>
<dl class="field-list simple">
<dt class="field-odd">Parameters</dt>
<dd class="field-odd"><ul class="simple">
<li><p><strong>resource_name</strong> (<em>str</em>) – The name of the resource.</p></li>
<li><p><strong>opts</strong> (<a class="reference internal" href="../pulumi/#pulumi.ResourceOptions" title="pulumi.ResourceOptions"><em>pulumi.ResourceOptions</em></a>) – Options for the resource.</p></li>
<li><p><strong>name</strong> (<em>pulumi.Input</em><em>[</em><em>str</em><em>]</em>) – The name of the vhost.</p></li>
</ul>
</dd>
</dl>
<dl class="py attribute">
<dt id="pulumi_rabbitmq.VHost.name">
<code class="sig-name descname">name</code><em class="property">: pulumi.Output[str]</em><em class="property"> = None</em><a class="headerlink" href="#pulumi_rabbitmq.VHost.name" title="Permalink to this definition">¶</a></dt>
<dd><p>The name of the vhost.</p>
</dd></dl>

<dl class="py method">
<dt id="pulumi_rabbitmq.VHost.get">
<em class="property">static </em><code class="sig-name descname">get</code><span class="sig-paren">(</span><em class="sig-param"><span class="n">resource_name</span></em>, <em class="sig-param"><span class="n">id</span></em>, <em class="sig-param"><span class="n">opts</span><span class="o">=</span><span class="default_value">None</span></em>, <em class="sig-param"><span class="n">name</span><span class="o">=</span><span class="default_value">None</span></em><span class="sig-paren">)</span><a class="headerlink" href="#pulumi_rabbitmq.VHost.get" title="Permalink to this definition">¶</a></dt>
<dd><p>Get an existing VHost resource’s state with the given name, id, and optional extra
properties used to qualify the lookup.</p>
<dl class="field-list simple">
<dt class="field-odd">Parameters</dt>
<dd class="field-odd"><ul class="simple">
<li><p><strong>resource_name</strong> (<em>str</em>) – The unique name of the resulting resource.</p></li>
<li><p><strong>id</strong> (<em>str</em>) – The unique provider ID of the resource to lookup.</p></li>
<li><p><strong>opts</strong> (<a class="reference internal" href="../pulumi/#pulumi.ResourceOptions" title="pulumi.ResourceOptions"><em>pulumi.ResourceOptions</em></a>) – Options for the resource.</p></li>
<li><p><strong>name</strong> (<em>pulumi.Input</em><em>[</em><em>str</em><em>]</em>) – The name of the vhost.</p></li>
</ul>
</dd>
</dl>
</dd></dl>

<dl class="py method">
<dt id="pulumi_rabbitmq.VHost.translate_output_property">
<code class="sig-name descname">translate_output_property</code><span class="sig-paren">(</span><em class="sig-param"><span class="n">prop</span></em><span class="sig-paren">)</span><a class="headerlink" href="#pulumi_rabbitmq.VHost.translate_output_property" title="Permalink to this definition">¶</a></dt>
<dd><p>Provides subclasses of Resource an opportunity to translate names of output properties
into a format of their choosing before writing those properties to the resource object.</p>
<dl class="field-list simple">
<dt class="field-odd">Parameters</dt>
<dd class="field-odd"><p><strong>prop</strong> (<em>str</em>) – A property name.</p>
</dd>
<dt class="field-even">Returns</dt>
<dd class="field-even"><p>A potentially transformed property name.</p>
</dd>
<dt class="field-odd">Return type</dt>
<dd class="field-odd"><p>str</p>
</dd>
</dl>
</dd></dl>

<dl class="py method">
<dt id="pulumi_rabbitmq.VHost.translate_input_property">
<code class="sig-name descname">translate_input_property</code><span class="sig-paren">(</span><em class="sig-param"><span class="n">prop</span></em><span class="sig-paren">)</span><a class="headerlink" href="#pulumi_rabbitmq.VHost.translate_input_property" title="Permalink to this definition">¶</a></dt>
<dd><p>Provides subclasses of Resource an opportunity to translate names of input properties into
a format of their choosing before sending those properties to the Pulumi engine.</p>
<dl class="field-list simple">
<dt class="field-odd">Parameters</dt>
<dd class="field-odd"><p><strong>prop</strong> (<em>str</em>) – A property name.</p>
</dd>
<dt class="field-even">Returns</dt>
<dd class="field-even"><p>A potentially transformed property name.</p>
</dd>
<dt class="field-odd">Return type</dt>
<dd class="field-odd"><p>str</p>
</dd>
</dl>
</dd></dl>

</dd></dl>

</div>
