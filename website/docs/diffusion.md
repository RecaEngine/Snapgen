---
title: Diffusion
---

Snapgen supports [`diffusers`](#diffusers) and [`stablediffusion`](#stablediffusion) backends.

## diffusers

`diffusers` backend uses the huggingface [`diffusers`](https://huggingface.co/docs/diffusers/en/index) library to generate images. This backend only supports CUDA runtime.

### Example

:::warning
Please make sure to change syntax to `#syntax=ghcr.io/sozercan/snapgen:latest` in the examples below.
:::

https://github.com/sozercan/snapgen/blob/main/test/snapgenfile-diffusers.yaml

## stablediffusion

https://github.com/EdVince/Stable-Diffusion-NCNN

This backend:
- provides support for Stable Diffusion models
- does not support CUDA runtime yet

:::note
This is an experimental backend and it may change in the future.
:::

### Example

:::warning
Please make sure to change syntax to `#syntax=ghcr.io/sozercan/snapgen:latest` in the examples below.
:::

https://github.com/sozercan/snapgen/blob/main/test/snapgenfile-stablediffusion.yaml

### Demo

https://www.youtube.com/watch?v=gh7b-rt70Ug
