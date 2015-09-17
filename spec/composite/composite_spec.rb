require_relative "../../composite/task"
require_relative "../../composite/composite_task"
require_relative "../../composite/make_cake_task"
require_relative "../../composite/make_batter_task"
require_relative "../../composite/fill_pan_task"
require_relative "../../composite/bake_task"
require_relative "../../composite/frost_task"
require_relative "../../composite/add_dry_ingredients_task"
require_relative "../../composite/add_liquid_ingredients_task"
require_relative "../../composite/mix_ingredients_task"

describe "composite pattern" do
  describe Task do
    let(:task) { Task.new("task") }

    it "has a title 'task'" do
      expect(task.title).to eq("task")
    end

    it "has time required of 0.0" do
      expect(task.time_required).to eq(0.0)
    end
  end

  describe CompositeTask do
    let(:composite_task) { CompositeTask.new("composite task") }

    it "has title 'composite task'" do
      expect(composite_task.title).to eq("composite task")
    end

    it "has empty sub tasks" do
      expect(composite_task.sub_tasks).to match([])
    end

    context "add/remove sub-tasks" do
      before(:example) do
        @sub_task = Task.new("task")
        @composite_task = CompositeTask.new("composite task")
        @composite_task << @sub_task
      end

      it "can add sub-task" do
        expect(@composite_task.sub_tasks).to include(@sub_task)
        expect(@composite_task.sub_tasks.size).to eq(1)
      end

      it "can remove sub-task" do
        @composite_task.remove_sub_task(@sub_task)
        expect(@composite_task.sub_tasks).not_to include(@sub_task)
        expect(@composite_task.sub_tasks.size).to eq(0)
      end
    end

    context "index accessability" do
      before(:example) do
        @first_sub_task = Task.new("first")
        @second_sub_task = Task.new("second")
        @composite_task = CompositeTask.new("composite task")
        @composite_task << @first_sub_task
        @composite_task << @second_sub_task
      end

      it "can access sub_task at specific index" do
        expect(@composite_task[0].title).to eq("first")
        expect(@composite_task[1].title).to eq("second")
      end

      it "can change sub_task at specific index" do
        @composite_task[0] = Task.new("0")
        @composite_task[1] = Task.new("1")
        @composite_task[2] = Task.new("2")
        expect(@composite_task[0].title).to eq("0")
        expect(@composite_task[1].title).to eq("1")
        expect(@composite_task[2].title).to eq("2")
      end
    end

    it "has time_required equal to the sum of all time_required by sub_tasks" do
      first_sub_task = double(Task)
      second_sub_task = double(Task)
      allow(first_sub_task).to receive(:time_required).and_return(1.5)
      allow(second_sub_task).to receive(:time_required).and_return(3.2)
      composite_task = CompositeTask.new("composite task")
      composite_task << first_sub_task
      composite_task << second_sub_task
      expect(composite_task.time_required).to eq(4.7)
    end
  end
end

describe MakeCakeTask do
  let(:make_cake_task) { MakeCakeTask.new }

  it "has title 'Make Cake'" do
    expect(make_cake_task.title).to eq("Make Cake")
  end

  it "has sub_task MakeBatterTask" do
    expect(make_cake_task.sub_tasks).to include(instance_of(MakeBatterTask))
  end

  it "has sub_task FillPanTask" do
    expect(make_cake_task.sub_tasks).to include(instance_of(FillPanTask))
  end

  it "has sub_task BakeTask" do
    expect(make_cake_task.sub_tasks).to include(instance_of(BakeTask))
  end

  it "has sub_task FrostTask" do
    expect(make_cake_task.sub_tasks).to include(instance_of(FrostTask))
  end

  it "requires 53 minutes" do
    expect(make_cake_task.time_required).to eq(53)
  end

  describe MakeBatterTask do
    let(:make_batter_task) { MakeBatterTask.new }

    it "has title 'Make Batter'" do
      expect(make_batter_task.title).to eq("Make Batter")
    end

    it "has sub-task AddDryIngredientsTask" do
      expect(make_batter_task.sub_tasks).to \
        include(instance_of(AddDryIngredientsTask))
    end

    it "has sub-task AddLiquidIngredientsTask" do
      expect(make_batter_task.sub_tasks).to \
        include(instance_of(AddLiquidIngredientsTask))
    end

    it "has sub-task MixIngredientsTask" do
      expect(make_batter_task.sub_tasks).to \
        include(instance_of(MixIngredientsTask))
    end

    it "requires 5.5 minutes" do
      expect(make_batter_task.time_required).to eq(5.5)
    end
  end

  context "leaf tasks" do
    describe FillPanTask do
      let(:fill_pan_task) { FillPanTask.new }

      it "has title 'Fill Pan'" do
        expect(fill_pan_task.title).to eq("Fill Pan")
      end

      it "requires 2.5 minutes" do
        expect(fill_pan_task.time_required).to eq(2.5)
      end
    end

    describe BakeTask do
      let(:bake_task) { BakeTask.new }

      it "has title 'Bake'" do
        expect(bake_task.title).to eq("Bake")
      end

      it "requires 42 minutes" do
        expect(bake_task.time_required).to eq(42)
      end
    end

    describe FrostTask do
      let(:frost_task) { FrostTask.new }

      it "has title 'Frost'" do
        expect(frost_task.title).to eq("Frost")
      end

      it "requires 3 minutes" do
        expect(frost_task.time_required).to eq(3)
      end
    end

    describe AddDryIngredientsTask do
      let(:add_dry_ingredients_task) { AddDryIngredientsTask.new }

      it "has title 'Add Dry Ingredients'" do
        expect(add_dry_ingredients_task.title).to eq("Add Dry Ingredients")
      end

      it "requires 1 minute" do
        expect(add_dry_ingredients_task.time_required).to eq(1)
      end
    end

    describe AddLiquidIngredientsTask do
      let(:add_liquid_ingredients_task) { AddLiquidIngredientsTask.new }

      it "has title 'Add Liquid Ingredients'" do
        expect(add_liquid_ingredients_task.title).to eq("Add Liquid Ingredients")
      end

      it "requires 1.5 minutes" do
        expect(add_liquid_ingredients_task.time_required).to eq(1.5)
      end
    end

    describe MixIngredientsTask do
      let(:mix_ingredients_task) { MixIngredientsTask.new }

      it "has title 'Mix Ingredients'" do
        expect(mix_ingredients_task.title).to eq("Mix Ingredients")
      end

      it "requires 3 minutes" do
        expect(mix_ingredients_task.time_required).to eq(3)
      end
    end
  end
end
