function addEvent(elementId, eventId) {
  document.getElementById(elementId).addEventListener('click', () => {
    fathom.trackGoal(eventId, 0);
  });
}

window.addEventListener('load', () => {
  const links = [
    {
      link: 'ext-link-gh',
      event: 'KCDLV8I8'
    },
    {
      link: 'ext-link-mastodon',
      event: 'ET8ULOOR'
    },
    {
      link: 'ext-link-email',
      event: '7IZNQY82'
    },
    {
      link: 'link-age',
      event: 'QKKCZXIK'
    },
    {
      link: 'link-pgp',
      event: 'AWC3YVGV'
    },
    {
      link: 'link-more',
      event: 'RPEDWQTC'
    },
    {
      link: 'ext-link-repo',
      event: 'IQGEGQBV'
    },
    {
      link: 'ext-link-commit-hash',
      event: 'BPTII8GI'
    }
  ];
  links.forEach(link => {
    try {
      addEvent(link.link, link.event)
    } catch (error) {
      console.error(error);
    }
  });
})