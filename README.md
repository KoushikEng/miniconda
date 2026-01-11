# Miniconda on Debian

This Docker image is based on `debian:latest` and installs the latest Miniconda3 distribution.

## Key points

- Installs `wget` to download the Miniconda installer.
- Downloads Miniconda3 and installs it silently to `/opt/miniconda`.
- Removes the installer after installation to keep the image small.
- Adds `/opt/miniconda/bin` to `PATH` via `ENV` so `conda` is available in the container.
- Runs `conda init --all` so shells started in the container have conda initialized.
- Sets the container `ENTRYPOINT` to `/bin/bash` (interactive shell).

## Dockerfile summary

- Base: `debian:latest`
- Miniconda installer: `https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh`
- Install location: `/opt/miniconda`
- PATH updated: `/opt/miniconda/bin` added to `PATH`
- Shell initialization: `conda init --all`

## Usage

### Use the prebuilt image from GHCR

You can pull and use the already built image directly from GitHub Container Registry:

```bash
docker pull ghcr.io/koushikeng/miniconda:latest
```

Run it:

```bash
docker run --rm -it ghcr.io/koushikeng/miniconda:latest
```

---

### Build the image

Build the image locally (run from the directory containing this `Dockerfile`):

```bash
docker build -t miniconda-debian:latest .
```

Run an interactive shell with conda available:

```bash
docker run --rm -it miniconda-debian:latest
# then inside the container you can run:
conda --version
conda info
```

---

## Notes

- Miniconda is installed to `/opt/miniconda` and the image modifies shell init files via `conda init` for convenience.
- If you need a different conda environment or packages, create a Dockerfile that starts `FROM miniconda:latest` and installs what you need.

## Auto accept conda TOS

To automatically accept the Anaconda Terms of Service (ToS) when *installing packages silently*, you need to configure the `conda-anaconda-tos` plugin using one of three methods. These methods are particularly useful for automated workflows and CI/CD environments.

### Methods to Auto-Accept the ToS

You can use a command-line flag, set an environment variable, or modify your `.condarc` file.

- **Using the command line (Conda >= 25.5.0):**  
    Run the following command in your terminal to set the configuration:
  
    ```bash
    conda config --set plugins.auto_accept_tos yes
    ```

    This modifies your `.condarc` file to persist the setting.

- **Setting an environment variable:**  
  Set the `CONDA_PLUGINS_AUTO_ACCEPT_TOS` environment variable to `"yes"` or `"1"`. This is often the most suitable method for Dockerfiles or CI/CD pipelines.
  
  - **In Bash/Zsh:**

    ```bash
    export CONDA_PLUGINS_AUTO_ACCEPT_TOS=yes
    ```

  - **In a Dockerfile:**

    ```dockerfile
    ENV CONDA_PLUGINS_AUTO_ACCEPT_TOS=yes
    ```

### Modifying the `.condarc` file

Add the following lines to your .condarc file to configure auto acceptance:

```yaml
plugins:
  auto_accept_tos: true
```

You can locate your `.condarc` file using the `conda config --show-sources` command.
