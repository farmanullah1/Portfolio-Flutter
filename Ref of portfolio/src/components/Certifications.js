import React, { useState } from 'react';
import { motion, AnimatePresence } from 'framer-motion';
import { FaSearch, FaExternalLinkAlt, FaAward } from 'react-icons/fa';

/* ── Inline SVG logos ─────────────────────────────────────── */
const UdemyLogo = () => (
  <svg viewBox="0 0 50 50" width="34" height="34" fill="none" xmlns="http://www.w3.org/2000/svg">
    <rect width="50" height="50" rx="10" fill="#A435F0"/>
    <path d="M10 16h4v11.5c0 2.5 1.5 4 4 4s4-1.5 4-4V16h4v11.5c0 4.5-3.1 7.5-8 7.5s-8-3-8-7.5V16z" fill="white"/>
    <circle cx="37" cy="33" r="3" fill="white"/>
  </svg>
);

const GoogleLogo = () => (
  <svg viewBox="0 0 50 50" width="34" height="34" xmlns="http://www.w3.org/2000/svg">
    <rect width="50" height="50" rx="10" fill="#fff"/>
    <path d="M34.5 25.2c0-.7-.1-1.4-.2-2H25v3.8h5.3c-.2 1.2-.9 2.2-2 2.9v2.4h3.2c1.9-1.7 3-4.3 3-7.1z" fill="#4285F4"/>
    <path d="M25 36c2.7 0 4.9-.9 6.5-2.4l-3.2-2.4c-.9.6-2 .9-3.3.9-2.5 0-4.6-1.7-5.4-4H16.3v2.5C17.9 33.8 21.2 36 25 36z" fill="#34A853"/>
    <path d="M19.6 28.1c-.2-.6-.3-1.3-.3-2s.1-1.4.3-2v-2.5h-3.3c-.7 1.4-1.1 2.9-1.1 4.5s.4 3.1 1.1 4.5l3.3-2.5z" fill="#FBBC05"/>
    <path d="M25 19.1c1.4 0 2.7.5 3.7 1.4l2.7-2.7C29.9 16.2 27.7 15 25 15c-3.8 0-7.1 2.2-8.7 5.5l3.3 2.5c.8-2.3 2.9-4 5.4-4z" fill="#EA4335"/>
  </svg>
);

const ISSUER_LOGO = { Udemy: <UdemyLogo />, Google: <GoogleLogo /> };

const CERTS = [
  { title: 'React Crash Course: From Zero to Hero', issuer: 'Udemy', date: 'Mar 2026', category: 'React', credentialId: 'UC-a83ae4f4-9639-4595-a11e-abc632404393', link: 'https://www.udemy.com/certificate/UC-a83ae4f4-9639-4595-a11e-abc632404393/', skills: ['React.js'], color: '#61DAFB' },
  { title: 'Microsoft Power BI – Complete Beginner to Advanced 2026', issuer: 'Udemy', date: 'Mar 2026', category: 'Other', credentialId: 'UC-53b26ea4-79f3-4e29-8e53-9883cb4b01fa', link: 'https://www.udemy.com/certificate/UC-53b26ea4-79f3-4e29-8e53-9883cb4b01fa/', skills: ['Power BI'], color: '#F2C811' },
  { title: 'Complete ASP.NET Core MVC 6 with Real-World Projects', issuer: 'Udemy', date: 'Jan 2026', category: '.NET', credentialId: 'UC-0d9450f9-88c2-47c6-b833-2b4fb97af3c7', link: 'https://www.udemy.com/certificate/UC-0d9450f9-88c2-47c6-b833-2b4fb97af3c7/', skills: ['ASP.NET', 'ASP.NET MVC', 'C#'], color: '#512BD4' },
  { title: 'C# 12 Mastery: From Console Apps to Web Development', issuer: 'Udemy', date: 'Jan 2026', category: '.NET', credentialId: 'UC-028be2e6-316d-4352-9562-b1de9bedelde', link: 'https://www.udemy.com/certificate/UC-028be2e6-316d-4352-9562-b1de9bedelde/', skills: ['C#'], color: '#512BD4' },
  { title: 'Docker MasterClass: Docker – Compose – SWARM – DevOps', issuer: 'Udemy', date: 'Dec 2025', category: 'DevOps', credentialId: 'UC-d45dbc33-c208-44e9-a9c4-655c96912424', link: 'https://www.udemy.com/certificate/UC-d45dbc33-c208-44e9-a9c4-655c96912424/', skills: ['Docker', 'DevOps'], color: '#2496ED' },
  { title: 'Google Prompting Essentials', issuer: 'Google', date: 'Jul 2025', category: 'AI', credentialId: 'FFFUSE07WB3E', link: 'https://www.coursera.org/account/accomplishments/verify/FFFUSE07WB3E', skills: ['Prompt Engineering', 'Generative AI'], color: '#4285F4' },
  { title: 'Introduction to Git and GitHub', issuer: 'Google', date: 'Jul 2025', category: 'DevOps', credentialId: 'VC6GFRYN0SA6', link: 'https://www.coursera.org/account/accomplishments/verify/VC6GFRYN0SA6', skills: ['Git', 'GitHub'], color: '#F05032' },
  { title: 'Crash Course on Python', issuer: 'Google', date: 'Jul 2025', category: 'Other', credentialId: 'DEKIOCTCC9HK', link: 'https://www.coursera.org/account/accomplishments/verify/DEKIOCTCC9HK', skills: ['Python'], color: '#3776AB' },
  { title: 'Ultimate YAML Course: YAML JSON JSONPath Zero to Master', issuer: 'Udemy', date: 'Jul 2025', category: 'DevOps', credentialId: 'UC-e8109738-fdc3-4650-8093-7780e2ad975b', link: 'https://www.udemy.com/certificate/UC-e8109738-fdc3-4650-8093-7780e2ad975b/', skills: ['YAML', 'JSON', 'DevOps'], color: '#CB171E' },
  { title: 'Computer Networks Fundamentals', issuer: 'Udemy', date: 'Jul 2025', category: 'Other', credentialId: 'UC-0af79858-5858-40c3-ae89-48f7223f008c', link: 'https://www.udemy.com/certificate/UC-0af79858-5858-40c3-ae89-48f7223f008c/', skills: ['Networking'], color: '#00b4d8' },
];

const FILTERS = ['All', '.NET', 'React', 'DevOps', 'AI', 'Other'];
const CAT_COLORS = { '.NET': '#7c3aed', React: '#61DAFB', DevOps: '#2496ED', AI: '#4285F4', Other: '#ffab40' };

const cardVariants = {
  hidden: { opacity: 0, y: 28, scale: 0.96 },
  visible: (i) => ({ opacity: 1, y: 0, scale: 1, transition: { delay: i * 0.055, duration: 0.42, ease: [0.4, 0, 0.2, 1] } }),
  exit: { opacity: 0, scale: 0.9, transition: { duration: 0.2 } },
};

const Certifications = () => {
  const [filter, setFilter] = useState('All');
  const [search, setSearch] = useState('');

  const visible = CERTS.filter((c) => {
    const mf = filter === 'All' || c.category === filter;
    const q = search.toLowerCase();
    const ms = c.title.toLowerCase().includes(q) || c.issuer.toLowerCase().includes(q) || c.skills.some((s) => s.toLowerCase().includes(q));
    return mf && ms;
  });

  return (
    <section className="certifications" id="certifications">
      <motion.h2 initial={{ opacity: 0, y: -20 }} whileInView={{ opacity: 1, y: 0 }} viewport={{ once: true }}>
        Licenses &amp; Certifications
      </motion.h2>

      {/* Stats bar */}
      <motion.div className="cert-stats-bar" initial={{ opacity: 0, y: 10 }} whileInView={{ opacity: 1, y: 0 }} viewport={{ once: true }} transition={{ delay: 0.1 }}>
        {[{ num: CERTS.length, label: 'Total Certs' }, { num: 2, label: 'Issuers' }, { num: 5, label: 'Categories' }].map((s, i) => (
          <React.Fragment key={i}>
            {i > 0 && <div className="cert-stat-divider" />}
            <div className="cert-stat">
              <span className="cert-stat-num">{s.num}</span>
              <span className="cert-stat-label">{s.label}</span>
            </div>
          </React.Fragment>
        ))}
      </motion.div>

      {/* Search */}
      <motion.div className="cert-search-wrap" initial={{ opacity: 0, y: 10 }} whileInView={{ opacity: 1, y: 0 }} viewport={{ once: true }} transition={{ delay: 0.15 }}>
        <FaSearch className="cert-search-icon" />
        <input type="text" className="cert-search" placeholder="Search by name, issuer, or skill…" value={search} onChange={(e) => setSearch(e.target.value)} />
        {search && <button className="cert-search-clear" onClick={() => setSearch('')}>✕</button>}
      </motion.div>

      {/* Filters */}
      <div className="filter-container">
        {FILTERS.map((f) => (
          <motion.button key={f} className={`filter-btn${filter === f ? ' active' : ''}`} onClick={() => setFilter(f)} whileHover={{ scale: 1.06 }} whileTap={{ scale: 0.94 }}>{f}</motion.button>
        ))}
      </div>

      {/* Grid */}
      <motion.div layout className="cert-grid-v2">
        <AnimatePresence mode="popLayout">
          {visible.map((c, i) => (
            <motion.div
              className="cert-card-v2"
              key={c.title}
              layout
              custom={i}
              variants={cardVariants}
              initial="hidden"
              animate="visible"
              exit="exit"
              whileHover={{ y: -7, scale: 1.015 }}
              style={{ '--cert-color': c.color }}
            >
              <div className="cert-card-bar" />

              <div className="cert-card-header">
                <div className="cert-logo-wrap">{ISSUER_LOGO[c.issuer] || <FaAward style={{ fontSize: '2rem', color: c.color }} />}</div>
                <div className="cert-category-badge" style={{ background: `${CAT_COLORS[c.category] || '#7c3aed'}22`, color: CAT_COLORS[c.category] || '#7c3aed', borderColor: `${CAT_COLORS[c.category] || '#7c3aed'}55` }}>
                  {c.category}
                </div>
              </div>

              <div className="cert-card-body">
                <h3 className="cert-card-title">{c.title}</h3>
                <div className="cert-issuer-row">
                  <span className="cert-issuer-name">{c.issuer}</span>
                  <span className="cert-date-badge">{c.date}</span>
                </div>
                <div className="cert-skills-row">
                  {c.skills.map((s) => (
                    <span key={s} className="cert-skill-chip" style={{ color: c.color, borderColor: `${c.color}55`, background: `${c.color}12` }}>{s}</span>
                  ))}
                </div>
                <div className="cert-id-row">
                  <span className="cert-id-label">ID:</span>
                  <span className="cert-id-value">{c.credentialId}</span>
                </div>
              </div>

              <div className="cert-card-footer">
                <a href={c.link} target="_blank" rel="noreferrer" className="cert-credential-btn">
                  <FaExternalLinkAlt /> Show Credential
                </a>
              </div>
            </motion.div>
          ))}
        </AnimatePresence>
        {visible.length === 0 && <p className="cert-empty">No certifications match your search.</p>}
      </motion.div>
    </section>
  );
};

export default Certifications;