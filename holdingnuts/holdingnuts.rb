require "formula"

class Holdingnuts < Formula
  desc "An open source multi-platform poker client and server"
  homepage "http://www.holdingnuts.net"
  url "https://github.com/holdingnuts/holdingnuts.git"
  head "https://github.com/holdingnuts/holdingnuts.git"

  depends_on "cmake" => :build
  depends_on "make" => :build
  depends_on "cartr/qt4/qt-legacy-formula"
  depends_on "sdl"
  depends_on "sqlite"

  def install
    ncpu = `sysctl -n hw.ncpu`.to_i
    mkdir("build") do
      system "cmake",
             "-DCMAKE_INSTALL_PREFIX=/usr/local",
             "-DCMAKE_DATA_PATH=/usr/local/share",
             "-DCMAKE_BUILD_TYPE=Release",
             "..",
             *std_cmake_args
      system "make", "-j#{ncpu}"
      system "make", "install", "prefix=#{prefix}"
    end
  end

  test do
    true
  end
end
