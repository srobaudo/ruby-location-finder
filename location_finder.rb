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
      instance = try_get_instance(target)
      if instance
        target.instance_methods.map{ |method|
          instance.method(method).source_location
        }.compact.map{ |s| s.first }.uniq
      end
    end

    def try_get_instance(target, param_count: 0)
      params = Array.new(param_count, '')
      target.new(*params)
    rescue ArgumentError => e
      try_get_instance(target, param_count: param_count + 1)
    rescue => e
      nil
    end
  end
end
