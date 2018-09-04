class Category < ApplicationRecord
  validates :url, presence:true, length: {maximum: 255},
          uniqueness: {case_sensitive: false}
  validates :title, presence:true, length: {maximum: 255}

  def get_category_tree
      category = Category.all.order(:order_no)
      format_tree(category, 0)
  end

  
  def format_tree(c, level)
      root = {:id => 0, :url => '#', :title => '#', :order_no => nil, :hidden => false, 
              :parent_id => nil}
      ### Active Record to hash
      c.each do |i|
          item = i.as_json.map { |key, value| [key.to_sym, value] }.to_h
          (@categories ||= []) << item
      end

      map = {}

      ### Vytvori hash mapu s id => item
      @categories.each do |item|
          map[item[:id]] = item
      end

      @tree = {}

      ### Naplni strom 
      @categories.each do |item|
          pid = item[:parent_id]
          if pid == nil || !map.has_key?(pid)
              ### Prida do korenu polozku pokud parent_id == nil
              (@tree[root] ||= []) << item
          else
              ### Priradi polozku ke spravne parent_id
              (@tree[map[pid]] ||= []) << item
          end
      end
  end

  def print_tree(root, level)
      items = @tree[root]
      unless items == nil
        indent = level > 0 ? sprintf("%#{level * 2}s", "  ") : ""
        items.each do |e|
          puts "#{indent}-#{e[:title]}"
          print_tree(e, level + 1)
        end
      end
  end
end
