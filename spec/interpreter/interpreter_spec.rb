require_relative "../../interpreter/expression"
require_relative "../../interpreter/all"
require_relative "../../interpreter/file_name"
require_relative "../../interpreter/bigger"
require_relative "../../interpreter/writable"
require_relative "../../interpreter/not"
require_relative "../../interpreter/or"
require_relative "../../interpreter/and"
require_relative "../../interpreter/parser"

describe Expression do
  it "parses expression correctly" do
    ast = bigger(1024) & name("*.lock") & writable
    expect(ast.evaluate(".")).to match(%w(Gemfile.lock))
  end
end

describe All do
  it "finds all files in directory" do
    expr_all = All.new
    results = expr_all.evaluate(".")
    expect(results.size).to eq(4)
  end
end

describe FileName do
  it "finds all non-hidden files" do
    expr_all = FileName.new("*")
    results = expr_all.evaluate(".")
    expect(results.size).to eq(3)
  end

  it "finds all files with .lock extension" do
    expr_all = FileName.new("*.lock")
    results = expr_all.evaluate(".")
    expect(results.size).to eq(1)
  end
end

describe Bigger do
  it "finds all files bigger than 1024 Bytes" do
    expr_big = Bigger.new(1024)
    results = expr_big.evaluate(".")
    expect(results.size).to eq(2)
  end

  it "finds all files bigger than 1360 Bytes" do
    expr_big = Bigger.new(1360)
    results = expr_big.evaluate(".")
    expect(results.size).to eq(1)
  end
end

describe Writable do
  it "finds writable files" do
    expr_wrt = Writable.new
    results = expr_wrt.evaluate(".")
    expect(results.size).to eq(4)
  end
end

describe Not do
  it "finds files not bigger than 1024 Bytes" do
    expr_not_big = Not.new(Bigger.new(1024))
    results = expr_not_big.evaluate(".")
    expect(results.size).to eq(2)
  end

  it "finds files that don't end with '.lock'" do
    expr_not_end = Not.new(FileName.new("*.lock"))
    results = expr_not_end.evaluate(".")
    expect(results.size).to eq(3)
  end
end

describe Or do
  it "finds files bigger than 1024 Bytes or end with .lock" do
    expr_big_or_lock = Or.new(Bigger.new(1024), FileName.new("*.lock"))
    results = %w(Gemfile.lock Guardfile)
    expect(expr_big_or_lock.evaluate(".")).to match(results)
  end
end

describe And do
  it "finds files bigger than 1024 Bytes and end with .lock" do
    expr_big_and_lock = And.new(Bigger.new(1024), FileName.new("*.lock"))
    expect(expr_big_and_lock.evaluate(".")).to match(%w(Gemfile.lock))
  end
end

describe Parser do
  it "tokenizes text properly" do
    parser = Parser.new("this ((is) a (hello world))")
    expect(parser.next_token).to eq("this")
    expect(parser.next_token).to eq("(")
    expect(parser.next_token).to eq("(")
    expect(parser.next_token).to eq("is")
    expect(parser.next_token).to eq(")")
    expect(parser.next_token).to eq("a")
    expect(parser.next_token).to eq("(")
    expect(parser.next_token).to eq("hello")
    expect(parser.next_token).to eq("world")
    expect(parser.next_token).to eq(")")
    expect(parser.next_token).to eq(")")
  end

  it "parses ast properly" do
    parser = Parser.new("and (and (bigger 1024) (filename *.lock)) writable")
    ast = parser.expression
    expect(ast.evaluate(".")).to match(%w(Gemfile.lock))
  end
end
