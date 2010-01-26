package net.sourceforge.fenixedu.presentationTier.renderers;

import net.sourceforge.fenixedu.domain.File;
import net.sourceforge.fenixedu.presentationTier.servlets.filters.ChecksumRewriter;
import net.sourceforge.fenixedu.presentationTier.servlets.filters.ContentInjectionRewriter;
import pt.ist.fenixWebFramework.renderers.OutputRenderer;
import pt.ist.fenixWebFramework.renderers.components.HtmlBlockContainer;
import pt.ist.fenixWebFramework.renderers.components.HtmlComponent;
import pt.ist.fenixWebFramework.renderers.components.HtmlLink;
import pt.ist.fenixWebFramework.renderers.components.HtmlLinkWithPreprendedComment;
import pt.ist.fenixWebFramework.renderers.components.HtmlText;
import pt.ist.fenixWebFramework.renderers.layouts.Layout;
import pt.ist.fenixWebFramework.renderers.utils.RenderUtils;

/**
 * This render is used to create a link to a File object. The form of the link
 * depends on the location of the contents of the file.
 * 
 * @author Pedro Santos
 */
public class FileLinkRenderer extends OutputRenderer {

    private String key;

    private String bundle;

    @Override
    protected Layout getLayout(Object object, Class type) {
	return new Layout() {

	    @Override
	    public HtmlComponent createComponent(Object object, Class type) {
		if (object != null && object instanceof File) {
		    File file = (File) object;
		    HtmlBlockContainer container = new HtmlBlockContainer();
		    container.addChild(new HtmlText(new String(ContentInjectionRewriter.BLOCK_HAS_CONTEXT_PREFIX), false));
		    HtmlLink link = getLink(file);
		    container.addChild(link);
		    container.addChild(new HtmlText(new String(ContentInjectionRewriter.END_BLOCK_HAS_CONTEXT_PREFIX), false));
		    link.setIndented(false);
		    link.setText(getLinkText(file));
		    return container;
		}
		return new HtmlLink();
	    }

	    private HtmlLink getLink(File file) {
		HtmlLink link = new HtmlLinkWithPreprendedComment(ChecksumRewriter.NO_CHECKSUM_PREFIX_HAS_CONTEXT_PREFIX);
		if (file.hasLocalContent()) {
		    link.setContextRelative(true);
		} else {
		    link.setContextRelative(false);
		}
		link.setModuleRelative(false);
		link.setUrl(file.getDownloadUrl());
		return link;
	    }

	    private String getLinkText(File file) {
		if (getKey() != null) {
		    return RenderUtils.getResourceString(getBundle(), getKey());
		}
		return file.getDisplayName();
	    }
	};
    }

    public String getKey() {
	return this.key;
    }

    /**
     * Instead of specifying thr {@link #setText(String) text} property you can
     * specify a key, with this property, and a bundle with the
     * {@link #setBundle(String) bundle}.
     * 
     * @property
     */
    public void setKey(String key) {
	this.key = key;
    }

    public String getBundle() {
	return this.bundle;
    }

    /**
     * The bundle were the {@link #setKey(String) key} will be fetched.
     * 
     * @property
     */
    public void setBundle(String bundle) {
	this.bundle = bundle;
    }
}
