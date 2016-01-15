class Spades < Formula
  desc "SPAdes: de novo genome assembly"
  homepage "http://bioinf.spbau.ru/spades/"

  # tag "bioinformatics"
  # doi "10.1089/cmb.2012.0021"

  url "http://spades.bioinf.spbau.ru/release3.6.2/SPAdes-3.6.2.tar.gz"
  sha256 "20897e2707623ee1033d3c88fefc42771fa4bbaafaf0f95642991d83b361eb5f"

  depends_on "cmake" => :build

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
