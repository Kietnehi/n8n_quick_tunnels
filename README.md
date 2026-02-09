# n8n Automation with Public Tunnels

This repository provides multiple Docker-based setups for running **n8n** (a self-hosted workflow automation tool) with different tunneling services to expose it securely to the internet. 

Ideal for testing webhooks, remote access, and rapid prototyping without needing static IPs or complex network configurations.

---

## 📦 Available Setups

Choose the setup that fits your needs:

| Setup | Tunnel Service | Best For | Key Features |
|-------|---------------|----------|--------------|
| **[n8n with Ngrok](n8n-ngrok/)** | Ngrok | Permanent domains, paid features | Configurable domains, Ngrok dashboard, stable URLs |
| **[n8n with Cloudflare (v1)](n8n_cloudfare1/)** | Cloudflare Quick Tunnel | Windows users, quick testing | Auto-copy URL, auto-open browser, colored CLI |
| **[n8n with Cloudflare (v2)](n8n_cloudfare2/)** | Cloudflare Quick Tunnel | Cross-platform, automation | Auto-updates `WEBHOOK_URL`, persistent data volume |

---

## 🚀 Quick Start

1.  **Clone this repository:**
    ```bash
    git clone [https://github.com/Kietnehi/n8n_quick_tunnels.git](https://github.com/Kietnehi/n8n_quick_tunnels.git)
    cd n8n_quick_tunnels
    ```

2.  **Navigate to your chosen folder:**
    * *Example:* `cd n8n-ngrok`

3.  **Run the setup:**
    * Follow the specific `README.md` inside that folder.
    * Typically run with: `docker-compose up -d`

---

## 🐢 Basic Usage: Run n8n Locally (No Tunnel)

If you only need to run n8n on your local machine without public internet access, follow these steps.

### 1. Create a Docker volume
This ensures your workflows and credentials are saved.
```bash
docker volume create n8n_data
```

### 2. Run n8n container
```bash
docker run -it --rm \
  --name n8n \
  -p 5678:5678 \
  -v n8n_data:/home/node/.n8n \
  docker.n8n.io/n8nio/n8n
```

### 3. Access n8n
Open your browser and go to: `http://localhost:5678`

> **Note:** The `--rm` flag removes the container when stopped. The `n8n_data` volume keeps your data safe.

---

## 🛠 General Requirements

* [Docker](https://docs.docker.com/get-docker/) & [Docker Compose](https://docs.docker.com/compose/install/)
* Git (to clone this repo)
* An account for the tunneling service (Ngrok or Cloudflare) if required by the specific setup.

---

## 📁 Repository Structure

```text
.
├── n8n-ngrok/          # n8n + Ngrok setup (permanent domains)
├── n8n_cloudfare1/     # n8n + Cloudflare (Windows-optimized)
├── n8n_cloudfare2/     # n8n + Cloudflare (cross-platform script)
└── README.md           # This file
```

---

## 🔗 Why Use These Tunnels?

* ✅ **No port forwarding** on your router required.
* ✅ **HTTPS included** automatically.
* ✅ **Dynamic IP support** (works anywhere).
* ✅ **Secure public access** for Webhook testing.
* ✅ **Persistent data volumes** included in all setups.

---

## 🤝 Contributing

Feel free to submit issues, improvements, or new tunnel service integrations via pull requests.

## 📄 License

MIT – Free to use, modify, and distribute.

---

## 🔗 Author

<div align="center">

<img src="https://capsule-render.vercel.app/api?type=waving&color=gradient&height=120&section=header"/>

<p align="center">
  <a href="https://github.com/Kietnehi">
    <img src="https://github.com/Kietnehi.png" width="140" height="140" style="border-radius: 50%; border: 4px solid #A371F7;" alt="Avatar Trương Phú Kiệt"/>
  </a>
</p>

<h3>🚀 Trương Phú Kiệt</h3>

<a href="https://github.com/Kietnehi">
  <img src="https://readme-typing-svg.herokuapp.com?font=Fira+Code&pause=1000&color=236AD3&background=00000000&center=true&vCenter=true&width=435&lines=Student+@+Sai+Gon+University;Fullstack+Dev+%26+AI+Researcher;Test+Model+In+Github" alt="Typing SVG" />
</a>

<br/><br/>

<p align="center">
  <img src="https://img.shields.io/badge/SGU-Sai_Gon_University-0056D2?style=flat-square&logo=google-scholar&logoColor=white" alt="SGU"/>
  <img src="https://img.shields.io/badge/Base-Ho_Chi_Minh_City-FF4B4B?style=flat-square&logo=google-maps&logoColor=white" alt="HCMC"/>
</p>

<p align="center">
  <a href="https://github.com/Kietnehi?tab=followers">
    <img src="https://img.shields.io/github/followers/Kietnehi?label=Followers&style=flat-square&logo=github"/>
  </a>
  <a href="https://github.com/Kietnehi">
    <img src="https://img.shields.io/github/stars/Kietnehi?label=Stars&style=flat-square&logo=github"/>
  </a>
</p>


<h3>🛠 Tech Stack</h3>
<p align="center">
  <a href="https://skillicons.dev">
    <img src="https://skillicons.dev/icons?i=docker,python,react,nodejs,mongodb,git,fastapi,pytorch&theme=light" alt="My Skills"/>
  </a>
</p>

<br/>

<h3>🌟 AI Model Demos & Experiments</h3>
<p align="center">
  <a href="https://github.com/Kietnehi/n8n_quick_tunnels">
    <img src="https://img.shields.io/github/stars/Kietnehi/n8n_quick_tunnels?style=for-the-badge&color=yellow" alt="Stars"/>
    <img src="https://img.shields.io/github/forks/Kietnehi/n8n_quick_tunnels?style=for-the-badge&color=orange" alt="Forks"/>
    <img src="https://img.shields.io/github/issues/Kietnehi/n8n_quick_tunnels?style=for-the-badge&color=red" alt="Issues"/>
  </a>
</p>

<p align="center">
  <img src="https://quotes-github-readme.vercel.app/api?type=horizontal&theme=dark" alt="Daily Quote"/>
</p>
<p align="center">
<i>Thank you for stopping by! Don’t forget to give this repo a <b>⭐️ Star</b> if you find it useful.</i>
</p>

<img src="https://capsule-render.vercel.app/api?type=waving&color=gradient&height=80&section=footer"/>

</div>

---