import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ 'linkNews', 'linkEasylives', 'linkInfoendos', 'linkForum', 'contentForum', 'contentNews', 'contentEasylives', 'contentInfoendos' ]

  connect() {
    if (this.data.get('name') == "infoendo") {
      this.linkInfoendosTarget.classList.add('active');
      this.contentInfoendosTarget.classList.add('show', 'active');
      this.linkNewsTarget.classList.remove('active');
      this.contentNewsTarget.classList.remove('show', 'active');
    } else if (this.data.get('name') == "webinar") {
      this.linkEasylivesTarget.classList.add('active');
      this.contentEasylivesTarget.classList.add('show', 'active');
      this.linkNewsTarget.classList.remove('active');
      this.contentNewsTarget.classList.remove('show', 'active');
     } else if (this.data.get('name') == "forum") {
      this.linkForumTarget.classList.add('active');
      this.contentForumTarget.classList.add('show', 'active');
      this.linkNewsTarget.classList.remove('active');
      this.contentNewsTarget.classList.remove('show', 'active');
     }  }

  openTab(e) {
    if (e.target.id == "pills-news-tab") {
      this.linkNewsTarget.classList.add('active');
      this.contentNewsTarget.classList.add('show', 'active');
      this.linkInfoendosTarget.classList.remove('active');
      this.contentInfoendosTarget.classList.remove('show', 'active');
      this.linkEasylivesTarget.classList.remove('active');
      this.contentEasylivesTarget.classList.remove('show', 'active');
      this.linkForumTarget.classList.remove('active');
      this.contentForumTarget.classList.remove('show', 'active');
    } else if (e.target.id == "pills-webinar-tab") {
      this.linkEasylivesTarget.classList.add('active');
      this.contentEasylivesTarget.classList.add('show', 'active');
      this.linkNewsTarget.classList.remove('active');
      this.contentNewsTarget.classList.remove('show', 'active');
      this.linkInfoendosTarget.classList.remove('active');
      this.contentInfoendosTarget.classList.remove('show', 'active');
      this.linkForumTarget.classList.remove('active');
      this.contentForumTarget.classList.remove('show', 'active');
    } else if (e.target.id == "pills-infoendo-tab") {
      this.linkInfoendosTarget.classList.add('active');
      this.contentInfoendosTarget.classList.add('show', 'active');
      this.linkNewsTarget.classList.remove('active');
      this.contentNewsTarget.classList.remove('show', 'active');
      this.linkEasylivesTarget.classList.remove('active');
      this.contentEasylivesTarget.classList.remove('show', 'active');
      this.linkForumTarget.classList.remove('active');
      this.contentForumTarget.classList.remove('show', 'active');
    } else if (e.target.id == "pills-forum-tab") {
      this.linkForumTarget.classList.add('active');
      this.contentForumTarget.classList.add('show', 'active');
      this.linkNewsTarget.classList.remove('active');
      this.contentNewsTarget.classList.remove('show', 'active');
      this.linkEasylivesTarget.classList.remove('active');
      this.contentEasylivesTarget.classList.remove('show', 'active');
      this.linkInfoendosTarget.classList.remove('active');
      this.contentInfoendosTarget.classList.remove('show', 'active');
    }
  }

}
