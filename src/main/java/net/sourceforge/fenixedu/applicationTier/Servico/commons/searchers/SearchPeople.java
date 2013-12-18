package net.sourceforge.fenixedu.applicationTier.Servico.commons.searchers;

import java.util.Collection;
import java.util.Map;

import org.fenixedu.bennu.core.presentationTier.renderers.autoCompleteProvider.AutoCompleteProvider;

import net.sourceforge.fenixedu.domain.Person;

public class SearchPeople implements AutoCompleteProvider<Person> {

    protected Collection<Person> search(final String value, final int size) {
        return Person.findPerson(value, size);
    }

    @Override
    public Collection<Person> getSearchResults(Map<String, String> argsMap, String value, int maxCount) {
        return search(value, maxCount);
    }

}
