using Project12.Models;
using System.Reflection;
using System.Text;
using System.Text.Json;
using System.Text.Json.Serialization;

namespace Project12
{
    public class Utils
    {
        public static void prompt()
        {
            Console.WriteLine($"Enter movie ID to borrow (or press Enter to exit):");

        }
        public static string Stringify<T>(T item){
            return Stringify(item, new HashSet<object>());
        }

        public static string Stringify(object item, HashSet<object> visited, int indent = 0)
        {
            if (item == null) return "null";
            if (visited.Contains(item)) return "(circular reference)";
            visited.Add(item);

            var type = item.GetType();
            string indentStr = new string(' ', indent * 2);
            string nextIndent = new string(' ', (indent + 1) * 2);

            // Primitive types
            if (type.IsPrimitive || item is decimal || item is bool)
                return item.ToString();
            if (item is string str)
                return str;

            // Dictionary
            if (typeof(System.Collections.IDictionary).IsAssignableFrom(type))
            {
                var dict = (System.Collections.IDictionary)item;
                var pairs = new List<string>();

                foreach (var key in dict.Keys)
                {
                    var value = dict[key];
                    var valueStr = Stringify(value, visited, indent + 1);
                    if (IsComplex(value))
                        pairs.Add($"\n{nextIndent}{key}: {valueStr}");
                    else
                        pairs.Add($"{key}: {valueStr}");
                }

                return pairs.Count > 0
                    ? string.Join(", ", pairs).TrimEnd(' ')
                    : "{}";
            }

            // Collection
            if (typeof(System.Collections.IEnumerable).IsAssignableFrom(type) && type != typeof(string))
            {
                var elements = new List<string>();
                foreach (var element in (System.Collections.IEnumerable)item)
                {
                    var elementStr = Stringify(element, visited, indent + 1);
                    if (IsComplex(element))
                        elements.Add($"\n{nextIndent} {elementStr}");
                    else
                        elements.Add($" {elementStr}");
                }

                return elements.Count > 0
                    ? string.Join(", ", elements)
                    : "[]";
            }

            // Object
            var props = type.GetProperties();
            var propPairs = new List<string>();

            foreach (var prop in props)
            {
                var value = prop.GetValue(item);
                var valueStr = Stringify(value, visited, indent + 1);

                if (IsComplex(value))
                    propPairs.Add($"\n{nextIndent}{prop.Name}: {valueStr}");
                else
                    propPairs.Add($"{prop.Name}: {valueStr}");
            }

            // If object has inner complex type, put on newlines
            bool hasInnerComplex = props.Any(p => IsComplex(p.GetValue(item)));

            if (hasInnerComplex)
                return string.Join(",", propPairs) + $"{indentStr}";
            else
                return string.Join(", ", propPairs);
        }

        private static bool IsComplex(object obj)
        {
            if (obj == null) return false;
            var t = obj.GetType();
            return !(t.IsPrimitive || obj is string || obj is decimal || obj is bool);
        }
    }
}