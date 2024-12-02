import os

from conan import ConanFile, tools
# from conan.tools.cmake import CMake, cmake_layout

class TestConan(ConanFile):
	settings = "os", "compiler", "build_type", "arch"
	# generators = "CMakeToolchain", "CMakeDeps"

	def requirements(self):
		self.requires(self.tested_reference_str)

#	def build(self):


	def test(self):
		self.run("make", env="conanrun") # env sets LD_LIBRARY_PATH etc. to find dependency libs
