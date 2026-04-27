import React from 'react';
import { motion } from 'framer-motion';
import { FaGithub, FaLinkedin, FaTwitter, FaHeart } from 'react-icons/fa';

const LINKS   = [
  { label:'About',          href:'#about'          },
  { label:'Projects',       href:'#projects'       },
  { label:'Experience',     href:'#experience'     },
  { label:'Certifications', href:'#certifications' },
  { label:'Contact',        href:'#contact'        },
];
const SOCIALS = [
  { href:'https://github.com/farmanullah1',                 icon:<FaGithub />,   label:'GitHub'   },
  { href:'https://www.linkedin.com/in/farmanullah-ansari',  icon:<FaLinkedin />, label:'LinkedIn' },
  { href:'https://x.com/farmanullah9088',                   icon:<FaTwitter />,  label:'Twitter'  },
];

const Footer = () => (
  <footer className="footer">
    <div className="footer-inner">
      <div className="footer-top">
        <div className="footer-brand">
          <a href="#home" className="footer-logo">Farmanullah.</a>
          <p className="footer-tagline">Building the web, one line at a time.</p>
          <div className="footer-social-icons">
            {SOCIALS.map((s,i) => (
              <motion.a key={i} href={s.href} target="_blank" rel="noreferrer" aria-label={s.label}
                whileHover={{ y:-5, scale:1.14 }} whileTap={{ scale:.9 }}>
                {s.icon}
              </motion.a>
            ))}
          </div>
        </div>
        <div className="footer-links-group">
          <h4>Quick Links</h4>
          <ul>{LINKS.map(l => <li key={l.label}><a href={l.href}>{l.label}</a></li>)}</ul>
        </div>
        <div className="footer-contact-group">
          <h4>Contact</h4>
          <p>farmanullahansari999@gmail.com</p>
          <p>Sindh, Pakistan</p>
          <p>Open to remote work worldwide</p>
        </div>
      </div>
      <div className="footer-bottom">
        <p>© {new Date().getFullYear()} Farmanullah Ansari. Built with <FaHeart className="footer-heart" /> using React.</p>
        <p className="footer-back"><a href="#home">Back to top ↑</a></p>
      </div>
    </div>
  </footer>
);
export default Footer;