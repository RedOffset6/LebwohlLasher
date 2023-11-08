from setuptools import setup, Extension
from Cython.Build import cythonize
import numpy as np

ext_modules = [
    Extension(
        "ll_functions",
        ["ll_functions.pyx"],
        include_dirs=[np.get_include()],  # This line is important for NumPy
    )
]

setup(
    ext_modules=cythonize(ext_modules),
)