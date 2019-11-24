# Darktable Noise Profile Generator Dockerfile

> Dockerfile to generate noise profiles for Darktable

Installing Darktable's noise profiler generator is a PITA in your work machine,
so I've made this dockerfile to use it whenever I want to generate new profiles.

## Requirements

Docker - Follow the [official instructions](https://docs.docker.com/install/).

## Build container

```shell
docker build -t darktablegennoiseprofile .
```

## Usage

Put your RAW images in the `pictures` folder. See [this](https://discuss.pixls.us/t/how-to-create-camera-noise-profiles-for-darktable/7428) on how to capture good images for noise profiling.

```shell
docker run -v $(pwd)/pictures:/pictures darktablegennoiseprofile
```

## License

GNU Lesser General Public License v3.0 or later
