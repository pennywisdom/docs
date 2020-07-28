---
title: "{{ replace .Name "-" " " | title }}"

# The date represents the date the course was created. Posts with future dates are visible
# in development, but excluded from production builds. Use the time and timezone-offset
# portions of of this value to schedule posts for publishing later.
date: {{ .Date }}

# Draft posts are visible in development, but excluded from production builds.
# Set this property to `false` before submitting the module for review.
draft: true

# Use the optional meta_desc property to provide a brief summary (one or two sentences)
# of the content of the module, which is useful for targeting search results or social-media
# previews.
description: Here is a brief description of what this module's all about.

# Use the optional meta_desc property to provide a brief summary (one or two sentences)
# of the content of the module, which is useful for targeting search results or social-media
# previews. If omitted, the description field will be used in its place.
meta_desc:

# The meta_image appears in social-media previews and on the Learn Pulumi home page.
# A placeholder image representing the recommended format, dimensions and aspect
# ratio has been provided for reference.
meta_image: meta.png

# At least one author is required. The values in this list correspond with the `id`
# properties of the team member files at /data/team/team. Create a file for yourself
# if you don't already have one.
authors:
    - christian-nunciato

# At least one tag is required. Lowercase, hyphen-delimited is recommended.
tags:
    - change-me

# Please remove these comments before submitting this module for review.
---

This is the content that will appear at the top of the module index page. It should
describe the overall goal of the module and briefly summaries what the reader will know
how to do by the end of it.
