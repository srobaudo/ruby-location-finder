class LocationFinder
  class << self
    def get_class_location(target, filter_ancestors_out: false)
      locations = Array.wrap(class_methods_locations(target)) +
        Array.wrap(instance_methods_locations(target))

      if filter_ancestors_out
        locations - target.ancestors[1..-1].flat_map{|target| get_class_location(target)}.uniq
      else
        locations
      end
    end

  private

    def class_methods_locations(target)
      target.methods.map{ |method|
        target.method(method).source_location
      }.compact.map{ |s| s.first }.uniq
    end

    def instance_methods_locations(target)
      target.instance_methods.map{ |method|
        target.instance_method(method).source_location
      }.compact.map{ |s| s.first }.uniq
    end
  end
end
