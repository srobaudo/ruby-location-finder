class LocationFinder
  class << self
    def get_class_location(target)
      Array.wrap(class_methods_locations(target)) +
        Array.wrap(instance_methods_locations(target))
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
