from setuptools import setup, find_packages

setup(
    name="getlibs",  # Replace with a meaningful name
    version="0.1.0",
    description="A Python tool to manage Docker containers and processes",
    author="Marco Pellero",
    url="https://github.com/MarcoPellero/getlibs",  # Replace with your repository URL
    license="MIT",
    classifiers=[
        "Programming Language :: Python :: 3",
        "License :: OSI Approved :: MIT License",
        "Operating System :: OS Independent",
    ],
    python_requires=">=3.7",
    packages=find_packages(),  # Automatically find packages in the project directory
    script=['./getlibs/getlibs.py',],
    entry_points={
        "console_scripts": [
            "getlibs=getlibs.getlibs:main",  # Expose a CLI command
        ],
    },
    install_requires=[
        "docker",
        "psutil",
    ],
)
