def my_each (obj)
  if obj.class == Array
    i = 0
    while i < obj.length
        yield obj[i]
        i += 1
    end
  elsif obj.class == Hash
    keys = obj.keys
    values = obj.values
    i = 0
    while i < keys.length && i < values.length
      yield keys[i], values[i]
      i += 1
    end
  end
end

def my_each_with_index (obj)
  if obj.class == Array
    i = 0
    while i < obj.length
        yield obj[i], i
        i += 1
    end
  end
end

def my_select (obj)
  if obj.class == Array
    i = 0
    selected = Array.new
    while i < obj.length
      if yield obj[i]
        selected.push obj[i]
      end
      i += 1
    end
  elsif obj.class == Hash
    keys = obj.keys
    values = obj.values
    i = 0
    selected = Hash.new
    while i < keys.length && i < values.length
      if yield keys[i], values[i]
        selected[keys[i]] = values[i]
      end
      i += 1
    end
  end
  return selected
end

def my_all? (obj)
  total_matches = 0

  if obj.class == Array
    i = 0
    while i < obj.length
      if yield obj[i]
        total_matches += 1
      end
      i += 1
    end
  elsif obj.class == Hash
    keys = obj.keys
    values = obj.values
    i = 0
    while i < keys.length && i < values.length
      if yield keys[i], values[i]
        total_matches += 1
      end
      i += 1
    end
  end
  if total_matches == obj.length 
    return true
  else 
    return false
  end
end

def my_any? (obj)
  if obj.class == Array
    i = 0
    while i < obj.length
      if yield obj[i]
        return true
      end
      i += 1
    end
  elsif obj.class == Hash
    keys = obj.keys
    values = obj.values
    i = 0
    while i < keys.length && i < values.length
      if yield keys[i], values[i]
        return true
      end
      i += 1
    end
  end
  return false
end

def my_none? (obj)
  if obj.class == Array
    i = 0
    while i < obj.length
      if yield obj[i]
        return false
      end
      i += 1
    end
  elsif obj.class == Hash
    keys = obj.keys
    values = obj.values
    i = 0
    while i < keys.length && i < values.length
      if yield keys[i], values[i]
        return false
      end
      i += 1
    end
  end
  return true
end

def my_count (obj)
  count = 0

  if obj.class == Array
    i = 0
    selected = Array.new
    while i < obj.length
      if yield obj[i]
        count += 1
      end
      i += 1
    end
  elsif obj.class == Hash
    keys = obj.keys
    values = obj.values
    i = 0
    selected = Hash.new
    while i < keys.length && i < values.length
      if yield keys[i], values[i]
        count += 1
      end
      i += 1
    end
  end
  return count
end

def my_map (obj)
  copy = []
  if obj.class == Array
    i = 0
    while i < obj.length
        copy.push yield obj[i]
        i += 1
    end
  end
  return copy
end

def my_inject (obj, initial=0)
  if obj.class == Array
    i = initial
    memo = 0
    while i < obj.length
        memo = yield memo, obj[i]
        i += 1
    end
  end
  return memo
end

my_array = [1, 2, 3, 4, 5]

my_hash = {
  name: "brown",
  age: 30,
  pounds: 200.89
}

my_each(my_array) { |element| puts element * 2 }

my_each(my_hash) do |key, value| 
  puts key
  puts value
end

my_each_with_index(my_array) { |element, index| puts "#{index}: #{element}" }

puts my_select(my_array) { |element| element > 3 }.inspect

puts my_select(my_hash) { |key, value| value == "brown" or (key.to_s == "age" && value > 18) }

# Should pass
puts my_all?(my_array) { |element| element > 0 }
puts my_all?(my_hash) { |key, value| key != nil }

# Should fail
puts my_all?(my_array) { |element| element > 3 }
puts my_all?(my_hash) { |key, value| value.is_a? Fixnum }

# Should pass
puts my_any?(my_array) { |element| element > 3 }
puts my_any?(my_hash) { |key, value| key.to_s == "name" }

# Should fail
puts my_any?(my_array) { |element| element < 1 }
puts my_any?(my_hash) { |key, value| key.to_s == "track_record" }

# Should pass
puts my_none?(my_array) { |element| element > 5 }
puts my_none?(my_hash) { |key, value| key.to_s == "favorite_color" }

# Should fail
puts my_none?(my_array) { |element| element == 5 }
puts my_none?(my_hash) { |key, value| key.to_s == "age" }

puts my_count(my_array) { |element| element > 2 }
puts my_count(my_hash) { |key, value| value.is_a? Numeric }

puts my_map(my_array) { |element| element + 100 }.inspect

puts my_inject(my_array) { |memo, element| memo + element }
puts my_inject(my_array, 3) { |memo, element| memo + element }