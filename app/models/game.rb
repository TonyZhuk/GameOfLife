class Game < ActiveRecord::Base
  @size = 20
  def self.start_game
    current_gen = Array.new(@size)
    current_gen.each_index do |i|
      current_gen[i] = Array.new(@size){0}
    end
    to_view(current_gen)
  end

  def self.to_view(next_gen)
    count = 0
    array = Array.new(@size*@size){0}
    for i in 0...@size
      for j in 0...@size
        array[count] = next_gen[i][j]
        count +=1
      end
    end
    array
  end

  def self.next_step(gen)
    gen = gen.map(&:to_i)
    current_gen = convert_array(gen)
    next_gen = next_gen(current_gen)
    to_view(next_gen)
  end

  def self.next_gen(current_gen)
    next_gen = Array.new(@size)
    next_gen.each_index do |i|
      next_gen[i] = Array.new(@size){0}
    end
    generate_next_gen(current_gen,next_gen)
  end

  def self.generate_next_gen(current_gen, next_gen)
    for i in 0...@size
      for j in 0...@size
        if current_gen[i][j] == 1
          if alive?(i,j,current_gen)
            next_gen[i][j] = 1
          end
        else
          if new_cell?(i,j,current_gen)
            next_gen[i][j] = 1
          end
        end
      end
    end
    next_gen
  end

  def self.alive?(i,j,current_gen)
    number_of_alives = count_of_alives(i,j,current_gen)

    if number_of_alives == 2 || number_of_alives == 3
      true
    else
      false
    end
  end

  def self.new_cell?(i,j,current_gen)
    number_of_alives = count_of_alives(i,j,current_gen)

    if number_of_alives == 3
      true
    else
      false
    end
  end


  def self.count_of_alives(i,j,current_gen)
    number_of_alives = 0

    (-1..1).each do |k|
      (-1..1).each do |l|
        if k == 0 && l == 0 then next end
        if current_gen[real_index(i+k)][real_index(j+l)] == 1 then number_of_alives += 1 end
      end
    end
    number_of_alives
  end

  def self.real_index(i)
    (@size + (i % @size)) % @size
  end

  def self.convert_array(array)
    converted = Array.new(@size)
    converted.each_index do |i|
      converted[i] = Array.new(@size){0}
    end
    count = 0
    for i in 0...@size
      for j in 0...@size
        converted[i][j] = array[count]
        count +=1
      end
    end
    converted
  end
end