# Snapgen

SnapGen is a compact, modular AI inference engine designed for rapid model prototyping and deployment. Whether you're building an AI-native application, testing multimodal LLMs, or integrating models into tools, SnapGen delivers a clean, extensible runtime for managing inference with precision and control.

---

## 📌 1. Introduction

SnapGen streamlines the process of launching and experimenting with modern large language models, vision-language models, and other generative systems. With built-in support for multiple inference providers, caching layers, and prompt orchestration, SnapGen provides a unified interface that adapts to your compute, project, or stack.

> Think of it as your personal AI switchboard — plug in a model, ask questions, and route the answers where they matter.

### Highlights

- Plug-and-play backends: OpenAI, Hugging Face, Ollama, Replicate, vLLM, and more  
- Built-in prompt formats and chaining support  
- Optional Redis memory & prompt caching  
- Local or remote deployment  
- CLI-first with Python integration

Whether you're building internal tools or public products, SnapGen scales from localhost experiments to production workflows.

### Supported Models (Out of the Box)

- GPT-4 / GPT-3.5 via OpenAI API  
- Mistral / Mixtral / LLaMA via Ollama  
- Vision-capable models via Replicate or local inference  
- Custom-hosted LLMs via vLLM

## ⚙️ 2. Installation & Setup

SnapGen is built to be lightweight, developer-friendly, and quick to configure. You can run it locally or integrate it into existing AI stacks with minimal setup.

### 🔧 Prerequisites

- Python 3.10 or newer  
- `make` (for quick commands)  
- Optional: Docker, Redis, Ollama, or local GPU runtime

### 🚀 Installing SnapGen

Clone the repository and install dependencies:

```
git clone https://github.com/your-org/snapgen.git  
cd snapgen  
make install  
```

If you're using a Python environment manager:

```
python -m venv .venv  
source .venv/bin/activate  
pip install -r requirements.txt  
```

### 🔑 Environment Variables

Create a `.env` file in the root directory to configure access keys and providers:

# .env

OPENAI_API_KEY=your-key-here  
REPLICATE_API_TOKEN=your-replicate-token  
OLLAMA_HOST=<http://localhost:11434>  
REDIS_URL=redis://localhost:6379/0  

```

Environment settings let you mix and match multiple backends and inference routes from the same interface.

### 🧪 Quick Test

Once installed and configured, you can run a test query:

```

make run MODEL=openai:gpt-3.5-turbo PROMPT="Explain gravity to a 5-year-old."  

```

Or use the CLI directly:

```

python snapgen/main.py --model ollama:mistral --prompt "Write a haiku about quantum physics."  

```

---

## 🧠 3. Architecture & Core Concepts

SnapGen is built around the idea of flexible model orchestration — instead of being tied to one provider or runtime, you define how prompts are routed, formatted, and processed.

### 🏗️ System Overview

--[[
  SnapGen System Diagram (ASCII)
  ------------------------------

            +--------------------------+
            |     SnapGen CLI / API    |
            +-------------+------------+
                          |
                          v
                  +---------------+
                  |   Core Engine |
                  +-------+-------+
                          |
            +-------------+-------------+
            |             |             |
            v             v             v
     +-----------+   +-----------+   +--------------+
     | Templates |   | Router    |   | Memory Cache |
     +-----------+   +-----------+   +--------------+
                          |
                          v
                 +------------------+
                 | Inference Backend|
                 | (OpenAI, Ollama) |
                 +------------------+

  Summary:
  - CLI/API is the entry point
  - Prompts pass through the Core Engine
  - Engine uses Templates and Router logic to format & route queries
  - Memory stores past interactions or context
  - Inference backend executes the final model call

--]]

### 🔁 Prompt Routing

Each call to SnapGen goes through the `router` — this dynamically determines which model to use based on the prompt, tags, or default settings.

```python
from snapgen.router import route_prompt

response = route_prompt(
    prompt="Write a poem about neural networks.",
    model="replicate:meta/llama-2-7b-chat",
    temperature=0.7,
    max_tokens=150
)
print(response.text)
```

### 🧩 Custom Chains

You can define sequences of prompts (chains) where the output of one step becomes input to the next.

```python
from snapgen.chains import Chain

chain = Chain([
    {"model": "openai:gpt-4", "prompt": "Summarize this article:\n{input}"},
    {"model": "openai:gpt-3.5-turbo", "prompt": "Convert the summary into a tweet thread."}
])

output = chain.run(input="Paste your long article here...")
print(output)
```

### 💡 Template-Aware Inference

Templates support slot-filling using Python-style `{variables}` for dynamic prompt construction. Combine this with metadata or user input to dynamically generate the final query.

---

## 🚀 4. Deployment & Integration

SnapGen is designed to be production-ready with minimal effort. Whether you want to host it as a microservice, plug it into your agent stack, or run it offline — SnapGen adapts to your workflow.

### 📦 Docker Deployment

Use the provided Dockerfile to containerize your setup.

```
docker build -t snapgen .  
docker run --env-file .env -p 8000:8000 snapgen  
```

SnapGen will expose an HTTP endpoint (via FastAPI) on port `8000`.

Access it with:

```
curl -X POST http://localhost:8000/query \
  -H "Content-Type: application/json" \
  -d '{"prompt": "Tell me a joke about entropy.", "model": "ollama:mistral"}'
```

### 🧠 Integration with AI Agents

SnapGen can act as the language layer for agents, workflows, and apps. Example with LangChain:

```python
from langchain.llms import OpenAI
from snapgen.bridge import LangChainWrapper

llm = LangChainWrapper(model="openai:gpt-3.5-turbo")
agent = initialize_agent(tools=[], llm=llm, agent_type="zero-shot-react-description")
```

You can also mount SnapGen into FastAPI or Flask apps as a callable engine.

### 🧩 Extending SnapGen

SnapGen is modular — you can add:

- Your own models via the `providers/` directory
- Custom memory layers (e.g., Pinecone, Milvus)
- New tools for post-processing (translation, summarization, etc.)
- Middleware for logging, rate-limiting, or monitoring

---

## 🧰 5. Resources, Credits & Roadmap

- Fine-tuned model support (LoRA, QLoRA)  
- Native multimodal input/output (images + text)  
- Web UI with playground and history  
- API key management for shared deployments  
- Analytics + cost tracking

### 🙌 Credits

Built and maintained by the SnapGen team — crafted for devs, agents, and AI explorers.  
Inspired by projects in the open-source LLM ecosystem.

> SnapGen is your command center for model orchestration — plug it in, turn it on, and watch your AI stack come alive
