
# n8n Automation with Public Tunnels

This repository provides multiple Docker-based setups for running **n8n** (a self-hosted workflow automation tool) with different tunneling services to expose it securely to the internet. Ideal for testing webhooks, remote access, and rapid prototyping without needing static IPs or complex network configurations.

---

## 📦 Available Setups

| Setup | Tunnel Service | Best For | Key Features |
|-------|---------------|----------|--------------|
| **[n8n with Ngrok](n8n-ngrok/)** | Ngrok | Permanent domains, paid features | Configurable domains, Ngrok dashboard, stable URLs |
| **[n8n with Cloudflare (v1)](n8n_cloudfare1/)** | Cloudflare Quick Tunnel (trycloudflare.com) | Windows users, quick testing | Auto-copy URL, auto-open browser, colored CLI |
| **[n8n with Cloudflare (v2)](n8n_cloudfare2/)** | Cloudflare Quick Tunnel (trycloudflare.com) | Cross-platform, simple automation | Auto-updates `WEBHOOK_URL`, persistent data volume |

---

## 🚀 Quick Start

1. **Choose a setup** based on your needs:
   - Need a permanent URL? → **Ngrok version**
   - On Windows and want automation? → **Cloudflare v1**
   - Prefer a simple, cross-platform script? → **Cloudflare v2**

2. **Navigate to the chosen folder** and follow its README.

3. **Run the setup script** (if available) or use `docker-compose up`.

---

## 🛠 General Requirements

- [Docker](https://docs.docker.com/get-docker/) and [Docker Compose](https://docs.docker.com/compose/install/)
- A tunneling service account (Ngrok or Cloudflare)
- Git (for cloning this repository)

---

## 📁 Repository Structure

```
.
├── n8n-ngrok/          # n8n + Ngrok setup (permanent domains)
├── n8n_cloudfare1/     # n8n + Cloudflare (Windows-optimized)
├── n8n_cloudfare2/     # n8n + Cloudflare (cross-platform)
└── README.md           # This file
```

Each folder contains its own `docker-compose.yml`, environment files, and setup scripts.

---

## 🔗 Why Use a Tunnel?

- **No port forwarding** required
- **HTTPS automatically provided**
- **Dynamic IP/DNS support**
- **Secure public access** to local n8n instances
- Perfect for **webhook testing** and **remote workflow management**

---

## 🧩 Features Across All Setups

- ✅ Self-hosted n8n in Docker
- ✅ Persistent data volumes
- ✅ Automatic tunnel URL detection
- ✅ Webhook-ready (`WEBHOOK_URL` auto-configured)
- ✅ One-command start/stop
- ✅ No static IP or domain required

---

## 🤝 Contributing

Feel free to submit issues, improvements, or new tunnel service integrations via pull requests.

---

## 📄 License

MIT – free to use, modify, and distribute.

---

## 🔗 Author's Github

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
<!-- Quote động -->
<p align="center">
  <img src="https://quotes-github-readme.vercel.app/api?type=horizontal&theme=dark" alt="Daily Quote"/>
</p>
<p align="center">
<i>Thank you for stopping by! Don’t forget to give this repo a <b>⭐️ Star</b> if you find it useful.</i>

</p>

<img src="https://capsule-render.vercel.app/api?type=waving&color=gradient&height=80&section=footer"/>

</div>


---
*Built for fast, secure, and flexible n8n testing and deployment. Happy automating! 🚀*