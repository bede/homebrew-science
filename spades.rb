class Spades < Formula
  desc "SPAdes: de novo genome assembly"
  homepage "http://bioinf.spbau.ru/spades/"
  # tag "bioinformatics"
  # doi "10.1089/cmb.2012.0021"i
  url "http://spades.bioinf.spbau.ru/release3.7.0/SPAdes-3.7.0.tar.gz"
  sha256 "4d9b114150c4d37084967a5a3264d36a480394996197949fb72402f2d65b42a3"

  bottle do
    cellar :any
    sha256 "c5c231cda3e42b5d163333c4dc85fb658dc601291b15dc14c4ae6499d65c8b0f" => :el_capitan
    sha256 "4c212477b615fb38507600b8b7ce539474fb115dc90155c6de312c37846b46a5" => :yosemite
    sha256 "81c4defa79e18fff8dad67052d69b0c08ede1fc3e4257c9f39a67c1c9dfa6a5a" => :mavericks
  end

  depends_on "cmake" => :build

  needs :openmp

  fails_with :gcc => "4.7" do
    cause "Compiling SPAdes requires GCC >= 4.7 for OpenMP 3.1 support"
  end

  def install
    mkdir "src/build" do
      system "cmake", "..", *std_cmake_args
      system "make", "install"
    end

    # Fix the audit error "Non-executables were installed to bin"
    inreplace bin/"spades_init.py" do |s|
      s.sub! /^/, "#!/usr/bin/env python\n"
    end
  end

  test do
    system "spades.py", "--test"
  end
end
