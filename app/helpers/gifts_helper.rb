module GiftsHelper

  def shorten_name(name)
    if name.length > 100
      name_arr = name.reverse.split("").slice_when {|char| char =~ /[\,\.\-]/}.to_a
      name_arr.shift
      shorten_name(name_arr.flatten.reverse.join(""))
    else
      name
    end
  end
end
